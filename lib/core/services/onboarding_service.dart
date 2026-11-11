import '../network/api_client.dart';

class OnboardingService {
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, dynamic>> createSession() async {
    return await _apiClient.post('/onboarding/session/');
  }

  Future<Map<String, dynamic>> savePracticeTime(String sessionId, Map<String, dynamic> data) async {
    return await _apiClient.put('/onboarding/$sessionId/practice-time/', body: data);
  }

  Future<Map<String, dynamic>> saveGrowthPlan(String sessionId, Map<String, dynamic> data) async {
    return await _apiClient.put('/onboarding/$sessionId/growth-plan/', body: data);
  }

  Future<Map<String, dynamic>> savePriorities(String sessionId, Map<String, dynamic> data) async {
    return await _apiClient.patch('/onboarding/$sessionId/priorities/', body: data);
  }

  Future<Map<String, dynamic>> submitAssessment(String sessionId, Map<String, dynamic> data) async {
    return await _apiClient.post('/onboarding/$sessionId/assessment/', body: data);
  }

  Future<Map<String, dynamic>> getAssessmentResult(String sessionId) async {
    return await _apiClient.get('/onboarding/$sessionId/assessment/');
  }

  Future<Map<String, dynamic>> getOnboardingAbilities(
    String sessionId, {
    String view = 'recommended',
  }) async {
    return await _apiClient.get('/onboarding/$sessionId/abilities/?view=$view');
  }

  Future<Map<String, dynamic>> saveOnboardingAbilities(
    String sessionId,
    List<int> abilityIds,
  ) async {
    return await _apiClient.put(
      '/onboarding/$sessionId/abilities/',
      body: {'ability_ids': abilityIds},
    );
  }
}
