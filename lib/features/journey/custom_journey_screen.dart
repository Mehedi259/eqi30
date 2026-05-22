import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_data.dart';

class CustomJourneyScreen extends StatefulWidget {
  const CustomJourneyScreen({super.key});

  @override
  State<CustomJourneyScreen> createState() => _CustomJourneyScreenState();
}

class _CustomJourneyScreenState extends State<CustomJourneyScreen> {
  final Map<String, int> _priorities = {};

  @override
  Widget build(BuildContext context) {
    final competencies = AppData.getCompetencies();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Custom Journey',
          style: AppTextStyles.heading4,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CUSTOM JOURNEY',
                      style: AppTextStyles.labelSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Build your own learning path.',
                      style: AppTextStyles.heading2.copyWith(fontSize: 26),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tap the number to set the priority for each competency. 1 = start first.',
                      style: AppTextStyles.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    // Info banner
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.accentOrange.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.accentOrange.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.info_outline,
                            color: AppColors.accentOrange,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'You can always switch to your AI recommended journey anytime.',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.accentOrange,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Competency list
                    ...competencies.asMap().entries.map((entry) {
                      final index = entry.key;
                      final competency = entry.value;
                      return _buildCompetencyItem(
                        competency.title,
                        competency.description,
                        competency.emoji,
                        Color(int.parse(competency.color)),
                        index,
                      );
                    }),
                  ],
                ),
              ),
            ),
            // Bottom buttons
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        context.push('/journey');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryDark,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Continue with my own journey',
                            style: AppTextStyles.buttonLarge,
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward, size: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      context.push('/journey');
                    },
                    child: Text(
                      'Go back to my recommended journey',
                      style: AppTextStyles.link.copyWith(
                        decoration: TextDecoration.underline,
                        color: AppColors.textPrimary,
                      ),
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

  Widget _buildCompetencyItem(
    String title,
    String subtitle,
    String emoji,
    Color borderColor,
    int index,
  ) {
    final priority = _priorities[title] ?? 0;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: borderColor.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: borderColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    emoji,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.heading5,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Priority selector
          Row(
            children: List.generate(6, (i) {
              final number = i + 1;
              final isSelected = priority == number;
              
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _priorities[title] = number;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      right: i < 5 ? 8 : 0,
                    ),
                    height: 44,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? borderColor
                          : borderColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Center(
                      child: Text(
                        '$number',
                        style: AppTextStyles.heading5.copyWith(
                          color: isSelected
                              ? Colors.white
                              : borderColor,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
