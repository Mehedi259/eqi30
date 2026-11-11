import 'package:flutter/material.dart';

/// Client-approved 7 emotion categories based on feelingswheel.com.
/// Maps unpleasant present states to target/hope states and coaching intents.
class FeelingsWheelCategory {
  final String title;
  final String helpIntent;
  final Color accentColor;
  final List<String> unpleasantWords;
  final List<String> hopeWords;

  const FeelingsWheelCategory({
    required this.title,
    required this.helpIntent,
    required this.accentColor,
    required this.unpleasantWords,
    required this.hopeWords,
  });
}

class FeelingsWheelData {
  FeelingsWheelData._();

  static const List<Map<String, String>> defaultQuickFeelings = [
    {'emoji': '😌', 'label': 'Calm'},
    {'emoji': '😠', 'label': 'Annoyed'},
    {'emoji': '🌱', 'label': 'Hopeful'},
    {'emoji': '😰', 'label': 'Anxious'},
    {'emoji': '😴', 'label': 'Depleted'},
    {'emoji': '🌀', 'label': 'Overwhelmed'},
    {'emoji': '🧐', 'label': 'Curious'},
  ];

  static const List<FeelingsWheelCategory> categories = [
    FeelingsWheelCategory(
      title: '1. Fear, Anxiety & Safety',
      helpIntent: 'Quiet my anxiety • Decision & Plan',
      accentColor: Color(0xFF0E7490),
      unpleasantWords: [
        'Anxious',
        'Agitated',
        'Restless',
        'Afraid',
        'Scared',
        'Paralyzed',
        'Frozen',
        'Skeptical',
        'Distrustful',
      ],
      hopeWords: [
        'Calm',
        'Tranquil',
        'At Ease',
        'Secure',
        'Safe',
        'Capable',
        'Empowered',
        'Trusting',
        'Reassured',
      ],
    ),
    FeelingsWheelCategory(
      title: '2. Anger, Agitation & Harmony',
      helpIntent: 'Boost my mood',
      accentColor: Color(0xFFB45309),
      unpleasantWords: [
        'Angry',
        'Mad',
        'Furious',
        'Frustrated',
        'Annoyed',
        'Irritated',
        'Bitter',
        'Hostile',
      ],
      hopeWords: [
        'Peaceful',
        'Composed',
        'Forgiving',
        'Content',
        'Patient',
        'Understood',
        'Compassionate',
        'Harmonious',
      ],
    ),
    FeelingsWheelCategory(
      title: '3. Sadness, Grief & Connection',
      helpIntent: 'Boost my mood',
      accentColor: Color(0xFF334155),
      unpleasantWords: [
        'Sad',
        'Unhappy',
        'Grief',
        'Heartbroken',
        'Hopeless',
        'Discouraged',
        'Lonely',
        'Isolated',
        'Melancholy',
      ],
      hopeWords: [
        'Comforted',
        'Healed',
        'Hopeful',
        'Encouraged',
        'Connected',
        'Belonging',
        'Serene',
        'Satisfied',
      ],
    ),
    FeelingsWheelCategory(
      title: '4. Energy, Exhaustion & Vitality',
      helpIntent: 'Boost my mood',
      accentColor: Color(0xFF0F766E),
      unpleasantWords: [
        'Depleted',
        'Drained',
        'Exhausted',
        'Numb',
        'Disconnected',
        'Bored',
        'Disengaged',
        'Somber',
      ],
      hopeWords: [
        'Energized',
        'Refreshed',
        'Engaged',
        'Present',
        'Curious',
        'Eager',
        'Upbeat',
      ],
    ),
    FeelingsWheelCategory(
      title: '5. Self-Worth, Shame & Acceptance',
      helpIntent: 'Anxiety & Boost my mood',
      accentColor: Color(0xFF6D28D9),
      unpleasantWords: [
        'Ashamed',
        'Insecure',
        'Inadequate',
        'Unseen',
        'Undervalued',
        'Embarrassed',
        'Comparison',
      ],
      hopeWords: [
        'Worthy',
        'Self-Compassionate',
        'Accepted',
        'Confident',
        'Validated',
        'Valued',
        'Authentic',
      ],
    ),
    FeelingsWheelCategory(
      title: '6. Vulnerability, Trust & Openness',
      helpIntent: 'Mood • Decision & Plan',
      accentColor: Color(0xFF6B705C),
      unpleasantWords: [
        'Defensive',
        'Guarded',
        'Stuck',
        'Trapped',
        'Blocked',
        'Hurt',
        'Guilty',
        'Remorseful',
      ],
      hopeWords: [
        'Open',
        'Trusting',
        'Vulnerable',
        'Free',
        'Flowing',
        'Protected',
        'Restored',
        'Forgiven',
      ],
    ),
    FeelingsWheelCategory(
      title: '7. Overwhelm, Control & Balance',
      helpIntent: 'Overwhelm • Help with a plan',
      accentColor: Color(0xFF073B4B),
      unpleasantWords: [
        'Overwhelmed',
        'Stressed',
        'Frazzled',
        'Flustered',
        'Disappointed',
        'Resentful',
        'Pressured',
      ],
      hopeWords: [
        'Grounded',
        'Focused',
        'Centered',
        'Fulfilled',
        'Grateful',
        'Appreciative',
        'Balanced',
      ],
    ),
  ];
}

/// Reusable bottom sheet allowing users to pick any emotion from the 7 Feelings Wheel families.
void showFeelingsWheelPickerSheet({
  required BuildContext context,
  String? selectedWord,
  required ValueChanged<String> onSelected,
}) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (ctx) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.72,
        maxChildSize: 0.92,
        builder: (_, scrollCtrl) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              controller: scrollCtrl,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Feelings Wheel Helper',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0B191D),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Notice what you feel (left) or the hopeful state you want to move toward (right):',
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'Inter',
                    color: Color(0xFF637275),
                  ),
                ),
                const SizedBox(height: 16),
                ...FeelingsWheelData.categories.map((cat) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: cat.accentColor.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                cat.title,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  color: cat.accentColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: cat.accentColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                cat.helpIntent,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  color: cat.accentColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Feeling right now:',
                          style: TextStyle(
                            fontSize: 11,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF64748B),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: cat.unpleasantWords.map((word) {
                            final isPicked = selectedWord == word;
                            return ActionChip(
                              label: Text(
                                word,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isPicked
                                      ? Colors.white
                                      : const Color(0xFF1E293B),
                                ),
                              ),
                              backgroundColor: isPicked
                                  ? cat.accentColor
                                  : Colors.white,
                              side: BorderSide(
                                color: cat.accentColor.withValues(alpha: 0.35),
                              ),
                              onPressed: () {
                                onSelected(word);
                                Navigator.of(ctx).pop();
                              },
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Hope / target state:',
                          style: TextStyle(
                            fontSize: 11,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0F766E),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: cat.hopeWords.map((word) {
                            final isPicked = selectedWord == word;
                            return ActionChip(
                              label: Text(
                                word,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isPicked
                                      ? Colors.white
                                      : const Color(0xFF065F46),
                                ),
                              ),
                              backgroundColor: isPicked
                                  ? const Color(0xFF0F766E)
                                  : const Color(0xFFECFDF5),
                              side: const BorderSide(color: Color(0xFF99F6E4)),
                              onPressed: () {
                                onSelected(word);
                                Navigator.of(ctx).pop();
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          );
        },
      );
    },
  );
}

