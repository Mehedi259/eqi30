import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class PrivacyTermsScreen extends StatelessWidget {
  const PrivacyTermsScreen({super.key});

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
          'Privacy & Terms',
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
                    'Privacy Policy',
                    style: AppTextStyles.heading5.copyWith(fontSize: 14),
                  ),
                  trailing: const Icon(Icons.chevron_right, color: AppColors.textGray),
                  onTap: () {
                    // Navigate to privacy policy details
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  title: Text(
                    'Terms of Service',
                    style: AppTextStyles.heading5.copyWith(fontSize: 14),
                  ),
                  trailing: const Icon(Icons.chevron_right, color: AppColors.textGray),
                  onTap: () {
                    // Navigate to terms of service details
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
