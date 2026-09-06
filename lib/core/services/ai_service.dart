import '../network/api_client.dart';

class AiService {
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, dynamic>> respondToChat(String message, {String? sessionId}) async {
    return await _apiClient.post(
      '/ai/chat/respond/',
      body: {
        'message': message,
        if (sessionId != null) 'session_id': sessionId,
      },
    );
  }
  
  Future<Map<String, dynamic>> analyzeAssessment(Map<String, dynamic> data) async {
    return await _apiClient.post('/ai/assessment/analyze/', body: data);
  }
  
  Future<Map<String, dynamic>> recommendJourney(Map<String, dynamic> data) async {
    return await _apiClient.post('/ai/journey/recommend/', body: data);
  }
}
