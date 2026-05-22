import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class HelpFaqScreen extends StatelessWidget {
  const HelpFaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          'Help & FAQ',
          style: AppTextStyles.heading4,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(
                    'Frequently Asked Questions',
                    style: AppTextStyles.heading5.copyWith(fontSize: 14),
                  ),
                  trailing: const Icon(Icons.chevron_right, color: AppColors.textGray),
                  onTap: () {
                    _showFAQDialog(context);
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  title: Text(
                    'Contact Support',
                    style: AppTextStyles.heading5.copyWith(fontSize: 14),
                  ),
                  trailing: const Icon(Icons.chevron_right, color: AppColors.textGray),
                  onTap: () {
                    context.push('/feedback');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showFAQDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('FAQs', style: AppTextStyles.heading3),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildFAQItem(
                'What is EQi30?',
                'EQi30 is a mobile app that helps professionals and leaders build emotional intelligence through 30 trainable abilities — with structured daily 5-minute micro-skill practices.',
              ),
              const SizedBox(height: 16),
              _buildFAQItem(
                'Who is EQi30 for?',
                'It\'s built for working professionals, team leaders, and organizational leaders who want to develop real emotional and leadership skills through consistent daily practice.',
              ),
              const SizedBox(height: 16),
              _buildFAQItem(
                'How much time do I need each day?',
                'As little as 5 minutes. You choose your own pace — 1, 2, or 3 abilities per day depending on your commitment level.',
              ),
              const SizedBox(height: 16),
              Text(
                '✉ Any other questions? Reach us at\nsupport@eqi30.com',
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: AppTextStyles.heading5.copyWith(fontSize: 14),
        ),
        const SizedBox(height: 4),
        Text(
          answer,
          style: AppTextStyles.bodySmall,
        ),
      ],
    );
  }
}
