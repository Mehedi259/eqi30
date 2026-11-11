import 'package:shared_preferences/shared_preferences.dart';
import '../network/api_client.dart';

class AuthService {
  final ApiClient _apiClient = ApiClient();

  // Save tokens to SharedPreferences
  Future<void> _saveToken(String token, {String? refreshToken}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    if (refreshToken != null) {
      await prefs.setString('refresh_token', refreshToken);
    }
  }

  // Clear tokens
  Future<void> _clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('refresh_token');
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await _apiClient.post(
      '/auth/login/',
      body: {'email': email, 'password': password},
    );
    
    // Check if the response contains tokens (usually access/refresh or token)
    if (response['tokens'] != null && response['tokens']['access'] != null) {
      await _saveToken(
        response['tokens']['access'],
        refreshToken: response['tokens']['refresh'],
      );
    } else if (response['access'] != null) {
      await _saveToken(response['access']);
    } else if (response['token'] != null) {
      await _saveToken(response['token']);
    }
    
    return response;
  }

  Future<Map<String, dynamic>> socialLogin({
    required String provider,
    required String email,
    String? fullName,
    String? token,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final sessionUuid = prefs.getString('onboarding_session_id');

    final body = <String, dynamic>{
      'provider': provider,
      'email': email,
      'full_name': fullName ?? (provider == 'google' ? 'Google User' : 'Apple User'),
    };
    if (token != null) body['token'] = token;
    if (sessionUuid != null) body['session_uuid'] = sessionUuid;

    final response = await _apiClient.post(
      '/auth/social-login/',
      body: body,
    );

    if (response['tokens'] != null && response['tokens']['access'] != null) {
      await _saveToken(
        response['tokens']['access'],
        refreshToken: response['tokens']['refresh'],
      );
    } else if (response['access'] != null) {
      await _saveToken(response['access']);
    } else if (response['token'] != null) {
      await _saveToken(response['token']);
    }
    if (response['onboarding_claimed'] == true) {
      await prefs.remove('onboarding_session_id');
    }

    return response;
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final sessionUuid = prefs.getString('onboarding_session_id');
    final body = <String, dynamic>{
      'full_name': name,
      'email': email,
      'password': password,
    };
    if (sessionUuid != null && sessionUuid.isNotEmpty) {
      body['session_uuid'] = sessionUuid;
    }

    final response = await _apiClient.post(
      '/auth/register/',
      body: body,
    );
    await prefs.setString('verify_email', email);
    if (response['onboarding_claimed'] == true) {
      await prefs.remove('onboarding_session_id');
    }
    return response;
  }

  Future<void> resendEmailOtp() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('verify_email') ?? '';
    if (email.isEmpty) {
      throw Exception('Email address not found. Please register again.');
    }
    await _apiClient.post(
      '/auth/resend-email-otp/',
      body: {'email': email},
    );
  }

  Future<void> resendPasswordResetOtp() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('verify_email') ?? '';
    if (email.isEmpty) {
      throw Exception('Email address not found. Please enter your email again.');
    }
    await _apiClient.post(
      '/auth/resend-otp/',
      body: {'email': email},
    );
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
      await _saveToken(
        response['tokens']['access'],
        refreshToken: response['tokens']['refresh'],
      );
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
      final prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString('refresh_token');
      await _apiClient.post(
        '/auth/logout/',
        body: refreshToken != null && refreshToken.isNotEmpty
            ? {'refresh': refreshToken}
            : null,
      );
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

  Future<void> changePassword(String currentPassword, String newPassword) async {
    await _apiClient.put(
      '/auth/change-password/',
      body: {
        'current_password': currentPassword,
        'new_password': newPassword,
      },
    );
  }

  Future<void> deleteAccount() async {
    await _apiClient.delete('/user/account/');
    await _clearToken();
  }
}
