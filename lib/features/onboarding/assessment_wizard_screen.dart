import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/services/onboarding_service.dart';
import 'models/assessment_data.dart';

class AssessmentWizardScreen extends StatefulWidget {
  const AssessmentWizardScreen({super.key});

  @override
  State<AssessmentWizardScreen> createState() => _AssessmentWizardScreenState();
}

class _AssessmentWizardScreenState extends State<AssessmentWizardScreen> {
  int _currentIndex = 0;
  final Map<int, int> _answers = {};
  bool _isSubmitting = false;

  final List<AssessmentQuestion> _questions = AssessmentData.questions;

  AssessmentQuestion get _currentQuestion => _questions[_currentIndex];

  double get _progress => (_currentIndex + 1) / _questions.length;

  void _selectScore(int score) {
    if (_isSubmitting) return;

    setState(() {
      _answers[_currentQuestion.id] = score;
    });

    // Auto advance after 220ms for smooth fluid experience
    Future.delayed(const Duration(milliseconds: 220), () {
      if (!mounted) return;
      _goToNext();
    });
  }

  void _goToPrevious() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    } else {
      if (context.canPop()) {
        context.pop();
      }
    }
  }

  void _goToNext() {
    if (_currentIndex < _questions.length - 1) {
      final nextIndex = _currentIndex + 1;
      final total = _questions.length;
      final q1 = (total / 4).round();
      final q2 = (total / 2).round();
      final q3 = (total * 3 / 4).round();

      if (nextIndex == q1) {
        _showMilestoneDialog('1/4 Completed 🎉', 'Great start! You have completed 1/4 of the questions.');
      } else if (nextIndex == q2) {
        _showMilestoneDialog('Halfway There! 🌟', 'Awesome progress — you have completed 1/2 of the questions.');
      } else if (nextIndex == q3) {
        _showMilestoneDialog('3/4 Completed 🔥', 'Almost at the finish line — 3/4 of the questions done!');
      } else {
        setState(() {
          _currentIndex = nextIndex;
        });
      }
    } else {
      _finishAssessment();
    }
  }

  void _showMilestoneDialog(String heading, String body) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F7F8),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF43BDC7), width: 2),
              ),
              child: const Center(
                child: Text('✨', style: TextStyle(fontSize: 32)),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              heading,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E3A42),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              body,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: const Color(0xFF4A6F75),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  setState(() {
                    _currentIndex++;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F3B4A),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "Keep Going",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _finishAssessment() async {
    setState(() {
      _isSubmitting = true;
    });

    try {
      // 1. Calculate scores across all 6 competencies
      final results = AssessmentData.calculateScores(_answers);
      debugPrint("Calculated EQ scores: $results");

      // 2. Persist detailed answers and computed results locally
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('eqi30_assessment_answers', jsonEncode(
        _answers.map((k, v) => MapEntry(k.toString(), v)),
      ));
      await prefs.setString('eqi30_assessment_results', jsonEncode(results));

      // 3. Submit to backend if session exists
      String? sessionId = prefs.getString('onboarding_session_id');
      if (sessionId == null) {
        final sessionRes = await OnboardingService().createSession();
        sessionId = sessionRes['session_uuid'];
        if (sessionId != null) {
          await prefs.setString('onboarding_session_id', sessionId);
        }
      }

      if (sessionId != null) {
        await OnboardingService().submitAssessment(sessionId, {
          'results': results,
        });
      }

      if (mounted) {
        context.go('/result-onboarding');
      }
    } catch (e) {
      debugPrint("Error submitting assessment: $e");
      if (mounted) {
        // Fallback: proceed to result screen even if offline
        context.go('/result-onboarding');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedScore = _answers[_currentQuestion.id];

    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xFFE2E8F0),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back, color: Color(0xFF1E3A42), size: 18),
          ),
          onPressed: _goToPrevious,
        ),
        title: Column(
          children: [
            Text(
              "EQi-30 Assessment",
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E3A42),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              "${(_progress * 100).round()}% Completed",
              style: GoogleFonts.inter(
                fontSize: 11,
                color: const Color(0xFF64748B),
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                "${_currentIndex + 1}/${_questions.length}",
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F3B4A),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: _isSubmitting
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(color: Color(0xFF43BDC7)),
                    const SizedBox(height: 24),
                    Text(
                      "Analyzing your 30 micro-abilities...",
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E3A42),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Crafting your personalized emotional intelligence blueprint.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  // Linear Progress Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: _progress,
                        minHeight: 6,
                        backgroundColor: const Color(0xFFE2E8F0),
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF43BDC7)),
                      ),
                    ),
                  ),

                  // Main Interactive Question Card
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),

                          // Question Statement
                          Text(
                            _currentQuestion.text,
                            style: GoogleFonts.inter(
                              fontSize: 22,
                              height: 1.35,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1E3A42),
                            ),
                          ),
                          const SizedBox(height: 12),

                          Text(
                            "Mark how accurately this reflects you (1 = Never, 10 = Always)",
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: const Color(0xFF64748B),
                            ),
                          ),

                          const SizedBox(height: 36),

                          // Quick-Tap 1 to 10 Number Grid / Pills
                          _buildRatingPills(selectedScore),

                          const SizedBox(height: 24),

                          // Rating Scale Legend
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.arrow_left, size: 16, color: Color(0xFF94A3B8)),
                                  Text(
                                    "1: Never",
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF64748B),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                selectedScore != null ? "Selected: $selectedScore/10" : "Tap a number to proceed",
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0F3B4A),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "10: Always",
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF64748B),
                                    ),
                                  ),
                                  const Icon(Icons.arrow_right, size: 16, color: Color(0xFF94A3B8)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Bottom Controls
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, -3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                          onPressed: _currentIndex > 0 ? _goToPrevious : null,
                          icon: const Icon(Icons.arrow_back, size: 16),
                          label: const Text("Previous"),
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFF4A6F75),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: selectedScore != null ? _goToNext : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0F3B4A),
                            disabledBackgroundColor: const Color(0xFFCBD5E1),
                            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: Row(
                            children: [
                              Text(
                                _currentIndex == _questions.length - 1 ? "Complete" : "Next",
                                style: GoogleFonts.inter(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.arrow_forward, size: 16, color: Colors.white),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildRatingPills(int? selectedScore) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = (constraints.maxWidth - 36) / 5;

        return Column(
          children: [
            // Row 1: Scores 1 to 5
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(5, (index) {
                final score = index + 1;
                final isSelected = selectedScore == score;
                return _buildPill(score, isSelected, itemWidth);
              }),
            ),
            const SizedBox(height: 12),
            // Row 2: Scores 6 to 10
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(5, (index) {
                final score = index + 6;
                final isSelected = selectedScore == score;
                return _buildPill(score, isSelected, itemWidth);
              }),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPill(int score, bool isSelected, double width) {
    return GestureDetector(
      onTap: () => _selectScore(score),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: width,
        height: 54,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0F3B4A) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF0F3B4A) : const Color(0xFFCBD5E1),
            width: isSelected ? 2.5 : 1.2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF0F3B4A).withValues(alpha: 0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ],
        ),
        child: Center(
          child: Text(
            "$score",
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
              color: isSelected ? Colors.white : const Color(0xFF1E3A42),
            ),
          ),
        ),
      ),
    );
  }
}
