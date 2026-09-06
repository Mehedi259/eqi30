import '../network/api_client.dart';

class ProfileService {
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, dynamic>> getProfile() async {
    return await _apiClient.get('/user/profile/');
  }

  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data) async {
    return await _apiClient.patch('/user/profile/', body: data);
  }

  Future<Map<String, dynamic>> getSubscriptionStatus() async {
    return await _apiClient.get('/subscription/status/');
  }
}
