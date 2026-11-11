import 'package:flutter_test/flutter_test.dart';
import 'package:eqi30/core/constants/feelings_wheel_data.dart';
import 'package:eqi30/features/onboarding/models/assessment_data.dart';

void main() {
  group('Client Doc 1 & Doc 2 Content Verification', () {
    test('Full assessment has exactly 102 questions and 13 reverse items', () {
      expect(AssessmentData.questions.length, 102);
      final ids = AssessmentData.questions.map((q) => q.id).toList();
      expect(ids, List<int>.generate(102, (i) => i + 1));

      final reverseIds = AssessmentData.questions
          .where((q) => q.isReverse)
          .map((q) => q.id)
          .toList();
      expect(reverseIds, [4, 6, 9, 12, 13, 15, 18, 36, 38, 39, 41, 44, 47]);
    });

    test('Short assessment has 48 questions across 6 competencies', () {
      expect(AssessmentData.shortQuestions.length, 48);
      final comps = AssessmentData.shortQuestions
          .map((q) => q.competencyKey)
          .toSet();
      expect(comps.length, 6);
    });

    test('calculateScores weights all 5 abilities properly even when 4 tie', () {
      final answers = <int, int>{for (var i = 1; i <= 102; i++) i: 8};
      // Set Processing Speed (items 87-89) to 4, leaving the other 4 DM abilities tied at 8.
      // True average = (4 + 8 + 8 + 8 + 8) / 5 = 7.2 -> 72.0% (old buggy code gave 60.0%).
      answers[87] = 4;
      answers[88] = 4;
      answers[89] = 4;

      final results = AssessmentData.calculateScores(answers);
      final dm = results.firstWhere((r) => r['competency'] == 'DECISION_MAKING');
      expect(dm['score'], 72.0);
    });

    test('calculateShortScores produces 6 ranked competencies', () {
      final answers = <int, int>{
        for (var i = 1; i <= 48; i++) i: i <= 8 ? 3 : 8,
      };
      final ranked = AssessmentData.calculateShortScores(answers);
      expect(ranked.length, 6);
      expect(ranked.first['competency'], 'SELF_MANAGEMENT');
      expect(ranked.first['ai_priority'], 1);
      expect(ranked.first['band'], 'growth area');
    });

    test('FeelingsWheelData defines all 7 client emotion categories', () {
      expect(FeelingsWheelData.categories.length, 7);
      for (final category in FeelingsWheelData.categories) {
        expect(category.unpleasantWords, isNotEmpty);
        expect(category.hopeWords, isNotEmpty);
      }
    });
  });
}
