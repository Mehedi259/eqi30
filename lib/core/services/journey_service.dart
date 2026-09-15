import '../network/api_client.dart';

class JourneyService {
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, dynamic>> getGuidedJourney() async {
    return await _apiClient.get('/guided-journey/');
  }

  Future<Map<String, dynamic>> getJourneyDetails() async {
    return await _apiClient.get('/journey/');
  }

  Future<Map<String, dynamic>> getTodayJourney() async {
    return await _apiClient.get('/journey/today/');
  }

  Future<Map<String, dynamic>> getJourneyHistory() async {
    return await _apiClient.get('/journey/history/');
  }

  Future<Map<String, dynamic>> completeSession(String sessionId, Map<String, dynamic> data) async {
    return await _apiClient.post('/sessions/$sessionId/complete/', body: data);
  }

  Future<Map<String, dynamic>> submitReflection(String sessionId, Map<String, dynamic> data) async {
    return await _apiClient.post('/sessions/$sessionId/reflection/', body: data);
  }

  Future<Map<String, dynamic>> getHomeDashboard() async {
    return await _apiClient.get('/home/dashboard/');
  }

  Future<Map<String, dynamic>> getProgressTrackerData() async {
    return await _apiClient.get('/progress/tracker/');
  }

  Future<Map<String, dynamic>> getPreviousJourneyAbilities() async {
    return await _apiClient.get('/journey/previous-abilities/');
  }

  Future<Map<String, dynamic>> getAbilityHistory(int abilityId) async {
    return await _apiClient.get('/journey/abilities/$abilityId/history/');
  }
}

