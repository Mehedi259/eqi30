import '../network/api_client.dart';

class SettingsService {
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, dynamic>> getPrivacyPolicy() async {
    return await _apiClient.get('/content/privacy-policy/');
  }

  Future<Map<String, dynamic>> getTermsOfService() async {
    return await _apiClient.get('/content/terms-of-service/');
  }

  Future<List<Map<String, dynamic>>> getFaqs() async {
    final res = await _apiClient.get('/content/faqs/');
    if (res is List) {
      return res.whereType<Map>().map((e) => Map<String, dynamic>.from(e)).toList();
    }
    if (res is Map && res['results'] is List) {
      return (res['results'] as List)
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    }
    return [];
  }

  Future<List<Map<String, dynamic>>> getSubscriptionPlans() async {
    final res = await _apiClient.get('/subscription/plans/');
    if (res is List) {
      return res.whereType<Map>().map((e) => Map<String, dynamic>.from(e)).toList();
    }
    if (res is Map && res['results'] is List) {
      return (res['results'] as List)
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    }
    return [];
  }

  Future<Map<String, dynamic>> getSubscriptionStatus() async {
    final res = await _apiClient.get('/subscription/status/');
    return res is Map ? Map<String, dynamic>.from(res) : {};
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

  Future<Map<String, dynamic>> changePassword(String currentPassword, String newPassword) async {
    return await _apiClient.put(
      '/auth/change-password/',
      body: {
        'current_password': currentPassword,
        'new_password': newPassword,
      },
    );
  }
}
