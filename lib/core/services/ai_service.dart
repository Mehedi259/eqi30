import '../network/api_client.dart';

class AiService {
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, dynamic>> respondToChat(String message, {String? sessionId, List<Map<String, String>> history = const []}) async {
    return await _apiClient.post(
      '/ai/chat/respond/',
      body: {
        'user_ref': sessionId ?? 'anonymous',
        'message': message,
        'history': history,
        'context': {
          'journey': {},
          'competency': {},
          'ability': {},
          'progress': {}
        }
      },
    );
  }
  
  Future<Map<String, dynamic>> analyzeAssessment(Map<String, dynamic> data) async {
    return await _apiClient.post('/ai/assessment/analyze/', body: data);
  }
  
  Future<Map<String, dynamic>> recommendJourney(Map<String, dynamic> data) async {
    return await _apiClient.post('/ai/journey/recommend/', body: data);
  }

  Future<Map<String, dynamic>> analyzeChatAssessment(List<Map<String, String>> history) async {
    return await _apiClient.post('/ai/chat/analyze/', body: {'history': history});
  }
}
