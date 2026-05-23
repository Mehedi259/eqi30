import 'package:flutter/material.dart';
import 'section_quick_win_banner.dart';

/// Example usage of SectionQuickWinBanner widget
///
/// This file demonstrates different ways to use the banner component

class SectionQuickWinBannerExamples extends StatelessWidget {
  const SectionQuickWinBannerExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(title: const Text('Quick Win Banner Examples')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Example 1: With Day Label',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 12),
            const SectionQuickWinBanner(
              title: 'You\'re 3 days into building\nEmotional Awareness...',
              description:
                  'Keep up the momentum! You\'re already identifying patterns faster than 60% of new learners.',
              dayLabel: 'Day 3',
              showTrophy: true,
            ),
            const SizedBox(height: 32),
            const Text(
              'Example 2: Without Day Label',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 12),
            const SectionQuickWinBanner(
              title: 'Great Progress on Stress Management!',
              description:
                  'You\'ve completed 5 sessions this week. Your consistency is paying off!',
              showTrophy: true,
            ),
            const SizedBox(height: 32),
            const Text(
              'Example 3: Without Trophy Icon',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 12),
            const SectionQuickWinBanner(
              title: 'New Milestone Unlocked!',
              description:
                  'You\'ve reached Level 5 in Self-Awareness. Keep exploring new techniques.',
              dayLabel: 'Level 5',
              showTrophy: false,
            ),
            const SizedBox(height: 32),
            const Text(
              'Example 4: Short Message',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 12),
            const SectionQuickWinBanner(
              title: 'Daily Streak: 7 Days! 🔥',
              description: 'Amazing! You\'re building a strong habit.',
              dayLabel: 'Week 1',
              showTrophy: true,
            ),
          ],
        ),
      ),
    );
  }
}
