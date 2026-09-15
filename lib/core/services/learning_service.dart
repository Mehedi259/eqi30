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
  Future<void> submitReflection(int sessionId, {String reflectionText = '', String response = '', String practiceAnswer = '', String realLifeAnswer = ''}) async {
    try {
      await _apiClient.post(
        '/sessions/$sessionId/reflection/',
        body: {
          if (reflectionText.isNotEmpty) 'reflection_text': reflectionText,
          if (response.isNotEmpty) 'response': response,
          if (practiceAnswer.isNotEmpty) 'practice_answer': practiceAnswer,
          if (realLifeAnswer.isNotEmpty) 'real_life_answer': realLifeAnswer,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Fetch competency intro for a specific ability
  Future<Map<String, dynamic>> getAbilityCompetencyIntro(int abilityId) async {
    try {
      final response = await _apiClient.get('/abilities/$abilityId/competency/');
      return response;
    } catch (e) {
      print('Error fetching competency intro: $e');
      rethrow;
    }
  }
}
