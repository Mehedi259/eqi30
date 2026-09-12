import 'package:shared_preferences/shared_preferences.dart';
import '../network/api_client.dart';

class AuthService {
  final ApiClient _apiClient = ApiClient();

  // Save tokens to SharedPreferences
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  // Clear tokens
  Future<void> _clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await _apiClient.post(
      '/auth/login/',
      body: {'email': email, 'password': password},
    );
    
    // Check if the response contains tokens (usually access/refresh or token)
    if (response['access'] != null) {
      await _saveToken(response['access']);
    } else if (response['token'] != null) {
      await _saveToken(response['token']);
    }
    
    return response;
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _apiClient.post(
      '/auth/register/',
      body: {
        'name': name,
        'email': email,
        'password': password,
      },
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('verify_email', email);
    return response;
  }

  Future<Map<String, dynamic>> verifyEmail(String otp) async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('verify_email') ?? '';
    // Requires email verification endpoint to accept OTP
    final response = await _apiClient.post(
      '/auth/verify-email/',
      body: {'email': email, 'otp': otp},
    );
    
    if (response['tokens'] != null && response['tokens']['access'] != null) {
      await _saveToken(response['tokens']['access']);
    }
    
    return response;
  }

  Future<Map<String, dynamic>> verifyOtp(String otp) async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('verify_email') ?? '';
    final response = await _apiClient.post(
      '/auth/verify-otp/',
      body: {'email': email, 'otp': otp},
    );
    return response;
  }

  Future<void> forgotPassword(String email) async {
    await _apiClient.post(
      '/auth/forgot-password/',
      body: {'email': email},
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('verify_email', email);
  }

  Future<void> resetPassword(String password, String otp) async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('verify_email') ?? '';
    await _apiClient.post(
      '/auth/reset-password/',
      body: {
        'email': email,
        'new_password': password,
        'otp': otp,
      },
    );
  }

  Future<void> logout() async {
    try {
      await _apiClient.post('/auth/logout/');
    } catch (_) {
      // Ignore errors if token is already expired when logging out
    } finally {
      await _clearToken();
    }
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('auth_token');
  }
}
