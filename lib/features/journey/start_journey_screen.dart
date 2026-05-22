import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class StartJourneyScreen extends StatelessWidget {
  final String competencyId;
  
  const StartJourneyScreen({super.key, required this.competencyId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    // Lung illustration
                    Container(
                      width: 280,
                      height: 320,
                      decoration: BoxDecoration(
                        color: AppColors.primaryDark,
                        borderRadius: BorderRadius.circular(140),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Simplified lung illustration
                          Positioned(
                            top: 80,
                            child: Container(
                              width: 160,
                              height: 180,
                              decoration: BoxDecoration(
                                color: AppColors.primaryTeal.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(80),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Left lung
                                  Container(
                                    width: 70,
                                    height: 140,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryCyan.withValues(alpha: 0.6),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(35),
                                        bottomLeft: Radius.circular(35),
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  // Right lung
                                  Container(
                                    width: 70,
                                    height: 140,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryCyan.withValues(alpha: 0.6),
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(35),
                                        bottomRight: Radius.circular(35),
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        'The stuff that nobody taught you.',
                        style: AppTextStyles.heading2.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            // Bottom buttons
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Primary button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        context.push('/chat');
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
                            'Let\'s try a 2-minute exercise',
                            style: AppTextStyles.buttonLarge,
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward, size: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Secondary button
                  TextButton(
                    onPressed: () {
                      context.push('/custom-journey');
                    },
                    child: Text(
                      'I already know what I want to work on.',
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
}
