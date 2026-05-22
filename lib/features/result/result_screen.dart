import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_data.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/progress_card.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final competencies = AppData.getCompetencies();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Result'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '✦ YOUR EQ SNAPSHOT',
                style: AppTextStyles.labelSmall,
              ),
              const SizedBox(height: 4),
              Text(
                'Here are you results',
                style: AppTextStyles.heading2,
              ),
              const SizedBox(height: 4),
              Text(
                'Selfmanagement Stress management Interpersonal Management Spirit Management Executive functioning and Decision Making.',
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: 24),
              
              // Progress Cards
              ProgressCard(
                title: competencies[0].title,
                status: competencies[0].status,
                percentage: competencies[0].percentage,
                statusColor: Color(int.parse(competencies[0].color)),
                isHighlighted: true,
                subtitle: 'Highest opportunity for growth',
                onTap: () => context.push(
                  '/abilities?competencyId=${competencies[0].id}&title=${competencies[0].title}',
                ),
              ),
              const SizedBox(height: 12),
              
              ProgressCard(
                title: competencies[1].title,
                status: competencies[1].status,
                percentage: competencies[1].percentage,
                statusColor: Color(int.parse(competencies[1].color)),
                onTap: () => context.push(
                  '/abilities?competencyId=${competencies[1].id}&title=${competencies[1].title}',
                ),
              ),
              const SizedBox(height: 12),
              
              ProgressCard(
                title: competencies[2].title,
                status: competencies[2].status,
                percentage: competencies[2].percentage,
                statusColor: Color(int.parse(competencies[2].color)),
                onTap: () => context.push(
                  '/abilities?competencyId=${competencies[2].id}&title=${competencies[2].title}',
                ),
              ),
              const SizedBox(height: 12),
              
              ProgressCard(
                title: competencies[3].title,
                status: competencies[3].status,
                percentage: competencies[3].percentage,
                statusColor: Color(int.parse(competencies[3].color)),
                onTap: () => context.push(
                  '/abilities?competencyId=${competencies[3].id}&title=${competencies[3].title}',
                ),
              ),
              const SizedBox(height: 12),
              
              ProgressCard(
                title: competencies[4].title,
                status: competencies[4].status,
                percentage: competencies[4].percentage,
                statusColor: Color(int.parse(competencies[4].color)),
                onTap: () => context.push(
                  '/abilities?competencyId=${competencies[4].id}&title=${competencies[4].title}',
                ),
              ),
              const SizedBox(height: 12),
              
              ProgressCard(
                title: competencies[5].title,
                status: competencies[5].status,
                percentage: competencies[5].percentage,
                statusColor: Color(int.parse(competencies[5].color)),
                onTap: () => context.push(
                  '/abilities?competencyId=${competencies[5].id}&title=${competencies[5].title}',
                ),
              ),
              const SizedBox(height: 32),
              
              Text(
                'Improve your skills in under 5 minutes daily  second line See you recommended journey',
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              
              CustomButton(
                text: 'START YOUR JOURNEY',
                onPressed: () => context.push('/journey'),
                icon: Icons.arrow_forward,
              ),
              const SizedBox(height: 12),
              
              CustomButton(
                text: 'Build my own journey',
                onPressed: () => context.push('/custom-journey'),
                isOutlined: true,
                icon: Icons.arrow_forward,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
