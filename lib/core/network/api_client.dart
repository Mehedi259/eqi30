import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'api_constants.dart';

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

  Future<dynamic> get(String endpoint) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}$endpoint');
    final headers = await _getHeaders();

    _log('GET $uri');
    _log('Headers: $headers');

    try {
      final response = await _client.get(uri, headers: headers);
      return _handleResponse(response);
    } catch (e) {
      _log('Error: $e');
      if (e is Exception && !e.toString().contains('SocketException')) {
        rethrow;
      }
      throw Exception('Network error: $e');
    }
  }

  Future<dynamic> post(String endpoint, {Map<String, dynamic>? body}) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}$endpoint');
    final headers = await _getHeaders();
    final encodedBody = body != null ? json.encode(body) : null;

    _log('POST $uri');
    _log('Headers: $headers');
    if (encodedBody != null) _log('Body: $encodedBody');

    try {
      final response = await _client.post(
        uri,
        headers: headers,
        body: encodedBody,
      );
      return _handleResponse(response);
    } catch (e) {
      _log('Error: $e');
      if (e is Exception && !e.toString().contains('SocketException')) {
        rethrow;
      }
      throw Exception('Network error: $e');
    }
  }
  
  Future<dynamic> put(String endpoint, {Map<String, dynamic>? body}) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}$endpoint');
    final headers = await _getHeaders();
    final encodedBody = body != null ? json.encode(body) : null;

    _log('PUT $uri');
    _log('Headers: $headers');
    if (encodedBody != null) _log('Body: $encodedBody');

    try {
      final response = await _client.put(
        uri,
        headers: headers,
        body: encodedBody,
      );
      return _handleResponse(response);
    } catch (e) {
      _log('Error: $e');
      if (e is Exception && !e.toString().contains('SocketException')) {
        rethrow;
      }
      throw Exception('Network error: $e');
    }
  }

  Future<dynamic> patch(String endpoint, {Map<String, dynamic>? body}) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}$endpoint');
    final headers = await _getHeaders();
    final encodedBody = body != null ? json.encode(body) : null;

    _log('PATCH $uri');
    _log('Headers: $headers');
    if (encodedBody != null) _log('Body: $encodedBody');

    try {
      final response = await _client.patch(
        uri,
        headers: headers,
        body: encodedBody,
      );
      return _handleResponse(response);
    } catch (e) {
      _log('Error: $e');
      if (e is Exception && !e.toString().contains('SocketException')) {
        rethrow;
      }
      throw Exception('Network error: $e');
    }
  }

  Future<dynamic> delete(String endpoint) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}$endpoint');
    final headers = await _getHeaders();

    _log('DELETE $uri');
    _log('Headers: $headers');

    try {
      final response = await _client.delete(uri, headers: headers);
      return _handleResponse(response);
    } catch (e) {
      _log('Error: $e');
      if (e is Exception && !e.toString().contains('SocketException')) {
        rethrow;
      }
      throw Exception('Network error: $e');
    }
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
