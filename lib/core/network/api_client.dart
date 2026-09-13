import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'api_constants.dart';
import '../routes/app_router.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  ApiClient._internal();

  final http.Client _client = http.Client();

  void _log(String message) {
    if (kDebugMode) {
      print('🌐 [API] $message');
    }
  }

  Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<bool> _refreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refresh_token');
    if (refreshToken == null) return false;

    try {
      final response = await _client.post(
        Uri.parse('${ApiConstants.baseUrl}/auth/token/refresh/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: json.encode({'refresh': refreshToken}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final newAccess = data['access'];
        final newRefresh = data['refresh'] ?? refreshToken;
        await prefs.setString('auth_token', newAccess);
        await prefs.setString('refresh_token', newRefresh);
        return true;
      }
    } catch (_) {}
    return false;
  }

  Future<dynamic> _requestWithRetry(Future<http.Response> Function() requestFunc, String endpoint) async {
    try {
      http.Response response = await requestFunc();
      
      // If unauthorized and it's not the refresh or login endpoint itself
      if (response.statusCode == 401 && !endpoint.contains('/auth/token/refresh') && !endpoint.contains('/auth/login')) {
        _log('Token expired, attempting to refresh...');
        final refreshed = await _refreshToken();
        if (refreshed) {
          _log('Token refreshed successfully. Retrying request...');
          // Retry the request with new headers
          response = await requestFunc();
        } else {
          _log('Failed to refresh token. Logging out...');
          // Refresh failed, clear tokens and redirect to login
          final prefs = await SharedPreferences.getInstance();
          await prefs.remove('auth_token');
          await prefs.remove('refresh_token');
          try {
            AppRouter.router.go('/login');
          } catch (_) {}
        }
      }
      
      return _handleResponse(response);
    } catch (e) {
      _log('Error: $e');
      if (e is Exception && !e.toString().contains('SocketException')) {
        rethrow;
      }
      throw Exception('Network error: $e');
    }
  }

  Future<dynamic> get(String endpoint) async {
    return _requestWithRetry(() async {
      final uri = Uri.parse('${ApiConstants.baseUrl}$endpoint');
      final headers = await _getHeaders();
      _log('GET $uri');
      _log('Headers: $headers');
      return await _client.get(uri, headers: headers);
    }, endpoint);
  }

  Future<dynamic> post(String endpoint, {Map<String, dynamic>? body}) async {
    final encodedBody = body != null ? json.encode(body) : null;
    return _requestWithRetry(() async {
      final uri = Uri.parse('${ApiConstants.baseUrl}$endpoint');
      final headers = await _getHeaders();
      _log('POST $uri');
      _log('Headers: $headers');
      if (encodedBody != null) _log('Body: $encodedBody');
      return await _client.post(uri, headers: headers, body: encodedBody);
    }, endpoint);
  }
  
  Future<dynamic> put(String endpoint, {Map<String, dynamic>? body}) async {
    final encodedBody = body != null ? json.encode(body) : null;
    return _requestWithRetry(() async {
      final uri = Uri.parse('${ApiConstants.baseUrl}$endpoint');
      final headers = await _getHeaders();
      _log('PUT $uri');
      _log('Headers: $headers');
      if (encodedBody != null) _log('Body: $encodedBody');
      return await _client.put(uri, headers: headers, body: encodedBody);
    }, endpoint);
  }

  Future<dynamic> patch(String endpoint, {Map<String, dynamic>? body}) async {
    final encodedBody = body != null ? json.encode(body) : null;
    return _requestWithRetry(() async {
      final uri = Uri.parse('${ApiConstants.baseUrl}$endpoint');
      final headers = await _getHeaders();
      _log('PATCH $uri');
      _log('Headers: $headers');
      if (encodedBody != null) _log('Body: $encodedBody');
      return await _client.patch(uri, headers: headers, body: encodedBody);
    }, endpoint);
  }

  Future<dynamic> delete(String endpoint) async {
    return _requestWithRetry(() async {
      final uri = Uri.parse('${ApiConstants.baseUrl}$endpoint');
      final headers = await _getHeaders();
      _log('DELETE $uri');
      _log('Headers: $headers');
      return await _client.delete(uri, headers: headers);
    }, endpoint);
  }

  dynamic _handleResponse(http.Response response) {
    _log('Response [${response.statusCode}]');
    _log('Response Body: ${response.body}');
    
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return json.decode(response.body);
    } else {
      String errorMessage = 'Something went wrong';
      try {
        final body = json.decode(response.body);
        if (body is Map && body.containsKey('detail')) {
          errorMessage = body['detail'];
        } else if (body is Map && body.containsKey('message')) {
          errorMessage = body['message'];
        } else if (body is Map && body.isNotEmpty) {
          // For DRF field errors like {"email": ["Email already exists"]}
          final firstValue = body.values.first;
          if (firstValue is List && firstValue.isNotEmpty) {
            errorMessage = firstValue.first.toString();
          } else {
            errorMessage = firstValue.toString();
          }
        } else {
           errorMessage = response.body;
        }
      } catch (_) {}
      
      throw Exception(errorMessage);
    }
  }
}
