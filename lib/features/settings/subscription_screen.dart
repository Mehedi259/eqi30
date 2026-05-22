import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

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
          'Subscriptions',
          style: AppTextStyles.heading4,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose Your Plan',
                style: AppTextStyles.heading2.copyWith(fontSize: 22),
              ),
              const SizedBox(height: 8),
              Text(
                'Select the subscription that best fits your emotional healing journey. Upgrade or cancel anytime.',
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: 24),
              
              // Basic Plan
              _buildPlanCard(
                title: 'Basic',
                price: '\$0',
                period: '/mo',
                description: 'Essential tools to begin your journey of self-awareness.',
                features: [
                  'Limited daily reflections',
                  'Basic emotion tracking',
                  'Access to community forums',
                ],
                buttonText: 'Start for Free',
                onTap: () {},
              ),
              const SizedBox(height: 16),
              
              // Pro Plan
              _buildPlanCard(
                title: 'Pro Plan',
                price: '\$9.99',
                period: '/mo',
                description: 'Full access to deepen your reflection and growth.',
                features: [
                  'Unlimited Meditations',
                  'Personalized Journeys',
                  'Yoga Video Library',
                  'Advanced Insights & Analytics',
                ],
                buttonText: 'Go Pro',
                onTap: () {},
                isHighlighted: true,
                badge: 'BEST VALUE',
              ),
              const SizedBox(height: 16),
              
              // Premium Plan
              _buildPlanCard(
                title: 'Premium',
                price: '\$19.99',
                period: '/mo',
                description: 'Dedicated support for a guided healing experience.',
                features: [
                  'Everything in Pro Plan',
                  '1-on-1 monthly coaching call',
                  'Priority therapist support',
                ],
                buttonText: 'Join Premium',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String price,
    required String period,
    required String description,
    required List<String> features,
    required String buttonText,
    required VoidCallback onTap,
    bool isHighlighted = false,
    String? badge,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isHighlighted ? AppColors.primaryDark : AppColors.borderLight,
          width: isHighlighted ? 2 : 1,
        ),
        boxShadow: [
          if (isHighlighted)
            BoxShadow(
              color: AppColors.primaryDark.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (badge != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryDark,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                badge,
                style: AppTextStyles.badgeSmall.copyWith(fontSize: 10),
              ),
            ),
          if (badge != null) const SizedBox(height: 12),
          
          Text(
            title,
            style: AppTextStyles.heading4,
          ),
          const SizedBox(height: 8),
          
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                price,
                style: AppTextStyles.heading2.copyWith(fontSize: 32),
              ),
              Text(
                period,
                style: AppTextStyles.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          Text(
            description,
            style: AppTextStyles.bodySmall,
          ),
          const SizedBox(height: 16),
          
          ...features.map((feature) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: AppColors.accentGreen,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    feature,
                    style: AppTextStyles.bodySmall,
                  ),
                ),
              ],
            ),
          )),
          const SizedBox(height: 16),
          
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: isHighlighted
                    ? AppColors.primaryDark
                    : Colors.white,
                foregroundColor: isHighlighted
                    ? Colors.white
                    : AppColors.primaryDark,
                side: BorderSide(
                  color: AppColors.primaryDark,
                  width: isHighlighted ? 0 : 1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                buttonText,
                style: AppTextStyles.buttonMedium.copyWith(
                  color: isHighlighted
                      ? Colors.white
                      : AppColors.primaryDark,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
