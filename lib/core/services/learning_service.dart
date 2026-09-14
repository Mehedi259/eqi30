import 'dart:convert';
import '../network/api_client.dart';

class LearningService {
  final ApiClient _apiClient = ApiClient();

  /// Fetch daily content for a specific ability
  Future<Map<String, dynamic>> getAbilityDayContent(int abilityId, int dayNumber) async {
    try {
      final response = await _apiClient.get('/abilities/$abilityId/days/$dayNumber/');
      return response;
    } catch (e) {
      print('Error fetching day content: $e');
      rethrow;
    }
  }

  /// Mark a session as completed
  Future<void> completeSession(int sessionId) async {
    try {
      await _apiClient.post('/sessions/$sessionId/complete/');
    } catch (e) {
      print('Error completing session: $e');
      rethrow;
    }
  }

  /// Submit daily reflection for a session
  Future<void> submitReflection(int sessionId, String reflectionText, {String response = ''}) async {
    try {
      await _apiClient.post(
        '/sessions/$sessionId/reflection/',
        body: {
          'reflection_text': reflectionText,
          'response': response,
        },
      );
    } catch (e) {
      print('Error submitting reflection: $e');
      rethrow;
    }
  }
}
