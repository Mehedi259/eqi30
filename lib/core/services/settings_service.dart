import '../network/api_client.dart';

class SettingsService {
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, dynamic>> getPrivacyPolicy() async {
    return await _apiClient.get('/content/privacy-policy/');
  }

  Future<Map<String, dynamic>> getTermsOfService() async {
    return await _apiClient.get('/content/terms-of-service/');
  }

  Future<Map<String, dynamic>> getFaqs() async {
    return await _apiClient.get('/content/faqs/');
  }

  Future<Map<String, dynamic>> submitFeedback(Map<String, dynamic> data) async {
    return await _apiClient.post('/feedback/', body: data);
  }

  Future<Map<String, dynamic>> getReminders() async {
    return await _apiClient.get('/user/reminders/');
  }

  Future<Map<String, dynamic>> updateReminders(Map<String, dynamic> data) async {
    return await _apiClient.put('/user/reminders/', body: data);
  }

  Future<Map<String, dynamic>> changePassword(String oldPassword, String newPassword) async {
    return await _apiClient.put(
      '/auth/change-password/',
      body: {
        'old_password': oldPassword,
        'new_password': newPassword,
      },
    );
  }
}
