import 'package:shared_preferences/shared_preferences.dart';
import '../network/api_client.dart';

class AiService {
  final ApiClient _apiClient = ApiClient();

  Future<String?> _resolveSessionUuid(String? explicitSessionId) async {
    if (explicitSessionId != null && explicitSessionId.isNotEmpty) {
      return explicitSessionId;
    }
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('onboarding_session_id');
  }

  Future<Map<String, dynamic>> respondToChat(
    String message, {
    String? sessionId,
    List<Map<String, String>> history = const [],
  }) async {
    final resolvedSession = await _resolveSessionUuid(sessionId);
    final body = <String, dynamic>{
      'user_ref': resolvedSession ?? 'anonymous',
      'message': message,
      'history': history,
      'context': {
        'journey': {},
        'competency': {},
        'ability': {},
        'progress': {},
      },
    };
    if (resolvedSession != null && resolvedSession.isNotEmpty) {
      body['session_uuid'] = resolvedSession;
    }
    return await _apiClient.post('/ai/chat/respond/', body: body);
  }

  Future<Map<String, dynamic>> analyzeAssessment(Map<String, dynamic> data) async {
    return await _apiClient.post('/ai/assessment/analyze/', body: data);
  }

  Future<Map<String, dynamic>> recommendJourney(Map<String, dynamic> data) async {
    return await _apiClient.post('/ai/journey/recommend/', body: data);
  }

  Future<Map<String, dynamic>> analyzeChatAssessment(
    List<Map<String, String>> history, {
    String? sessionId,
  }) async {
    final resolvedSession = await _resolveSessionUuid(sessionId);
    return await _apiClient.post(
      '/ai/chat/analyze/',
      body: {
        'history': history,
        if (resolvedSession != null && resolvedSession.isNotEmpty)
          'session_uuid': resolvedSession,
      },
    );
  }

  Future<Map<String, dynamic>> getSuggestions() async {
    return await _apiClient.get('/ai/suggestions/');
  }
}
