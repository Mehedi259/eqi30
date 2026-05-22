import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

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
          'Resource',
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
                'EXPLORE & LEARN',
                style: AppTextStyles.labelSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Resource Hub',
                style: AppTextStyles.heading2.copyWith(fontSize: 26),
              ),
              const SizedBox(height: 4),
              Text(
                'Meditations · Yoga · Articles · Journeys',
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: 24),
              
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search resources...',
                  hintStyle: AppTextStyles.bodyMedium,
                  prefixIcon: const Icon(Icons.search, color: AppColors.textGray),
                  filled: true,
                  fillColor: AppColors.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Filter Tabs
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip('All', true),
                    const SizedBox(width: 8),
                    _buildFilterChip('Meditation', false),
                    const SizedBox(width: 8),
                    _buildFilterChip('Yoga', false),
                    const SizedBox(width: 8),
                    _buildFilterChip('Articles', false),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Featured Today
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Featured Today',
                    style: AppTextStyles.heading4,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See all',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primaryTeal,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Featured Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.music_note, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                'Meditation Audio',
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Morning Calm\n— Body Scan',
                            style: AppTextStyles.heading4,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '12 min · Audio Guide',
                            style: AppTextStyles.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 56,
                      height: 56,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryTeal,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Meditation Audio Section
              Text(
                'Meditation Audio',
                style: AppTextStyles.heading4,
              ),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: _buildResourceCard(
                      'Morning Body Scan',
                      '10 min',
                      'Beginner',
                      AppColors.accentGreen,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildResourceCard(
                      'Stress Release Flow',
                      '15 min',
                      'Intermediate',
                      AppColors.primaryTeal,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Yoga & Movement Section
              Text(
                'Yoga & Movement',
                style: AppTextStyles.heading4,
              ),
              const SizedBox(height: 16),
              
              _buildYogaItem(
                '🧘',
                'Yoga for Emotional Release',
                'Video Guide',
                '25m',
              ),
              const SizedBox(height: 12),
              _buildYogaItem(
                '🌬️',
                'Breathwork & Pranayama',
                'Guided Session',
                '15m',
              ),
              const SizedBox(height: 12),
              _buildYogaItem(
                '💪',
                'Yoga for Stress Recovery',
                'Video Guide',
                '30m',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryDark : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? AppColors.primaryDark : AppColors.borderLight,
        ),
      ),
      child: Text(
        label,
        style: AppTextStyles.bodySmall.copyWith(
          color: isSelected ? Colors.white : AppColors.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildResourceCard(
    String title,
    String duration,
    String level,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              level,
              style: AppTextStyles.badgeSmall.copyWith(fontSize: 10),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: AppTextStyles.heading5.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            duration,
            style: AppTextStyles.bodySmall,
          ),
          const SizedBox(height: 12),
          const Icon(Icons.play_circle_outline, size: 24),
        ],
      ),
    );
  }

  Widget _buildYogaItem(
    String emoji,
    String title,
    String subtitle,
    String duration,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 24)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.heading5.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
          Text(
            duration,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textGray,
            ),
          ),
        ],
      ),
    );
  }
}
