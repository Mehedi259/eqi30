import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_data.dart';

class AbilitiesScreen extends StatelessWidget {
  final String competencyId;
  final String competencyTitle;

  const AbilitiesScreen({
    super.key,
    required this.competencyId,
    required this.competencyTitle,
  });

  @override
  Widget build(BuildContext context) {
    final abilities = AppData.getAbilitiesByCompetency(competencyId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Abilities Under Competency'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Icon
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.primaryTeal.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Center(
                    child: Text('🧠', style: TextStyle(fontSize: 50)),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              Text(
                '✦ ${competencyTitle.toUpperCase()}',
                style: AppTextStyles.labelSmall,
              ),
              const SizedBox(height: 8),
              
              Text(
                '5 Abilities to Build',
                style: AppTextStyles.heading2,
              ),
              const SizedBox(height: 8),
              
              Text(
                'Each ability is a focused 30–60 day micro-skill journey. Start with one.',
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: 24),
              
              // Abilities List
              ...abilities.map((ability) => Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          ability.emoji,
                          style: const TextStyle(fontSize: 28),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ability.title,
                            style: AppTextStyles.heading5,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            ability.description,
                            style: AppTextStyles.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.progressBackground,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        ability.status,
                        style: AppTextStyles.badgeSmall.copyWith(
                          color: AppColors.textGray,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
