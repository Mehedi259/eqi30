import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class ProgressCard extends StatelessWidget {
  final String title;
  final String status;
  final double percentage;
  final Color statusColor;
  final bool isHighlighted;
  final String? subtitle;
  final VoidCallback? onTap;

  const ProgressCard({
    super.key,
    required this.title,
    required this.status,
    required this.percentage,
    required this.statusColor,
    this.isHighlighted = false,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: isHighlighted ? AppColors.highlightedCardBg : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isHighlighted ? AppColors.borderDark : AppColors.borderLight,
            width: isHighlighted ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isHighlighted ? AppColors.shadowLight : AppColors.shadowCard,
              blurRadius: isHighlighted ? 24 : 20,
              offset: Offset(0, isHighlighted ? 8 : 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Title and Status
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: AppTextStyles.heading5,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Text(
                          status,
                          style: AppTextStyles.badge,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                
                // Progress Bar
                Container(
                  width: double.infinity,
                  height: 8,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: isHighlighted 
                        ? AppColors.progressBackgroundDark 
                        : AppColors.progressBackground,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Stack(
                    children: [
                      FractionallySizedBox(
                        widthFactor: percentage / 100,
                        child: Container(
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(9999),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                
                // Subtitle or Percentage
                if (subtitle != null)
                  Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            subtitle!,
                            style: AppTextStyles.labelMedium.copyWith(
                              color: AppColors.accentCyan,
                            ),
                          ),
                        ),
                        Text(
                          '${percentage.toInt()}%',
                          style: AppTextStyles.labelLarge.copyWith(
                            color: AppColors.primaryDarkAlt,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Text(
                    '${percentage.toInt()}%',
                    textAlign: TextAlign.right,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textGray,
                    ),
                  ),
              ],
            ),
            
            // "Start from here" badge for highlighted card
            if (isHighlighted)
              Positioned(
                right: 0,
                top: -16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryDarkAlt,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Start from here',
                    style: AppTextStyles.badgeSmall,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
