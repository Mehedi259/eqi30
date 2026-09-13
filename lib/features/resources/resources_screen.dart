import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/services/resource_service.dart';
import '../../core/network/api_constants.dart';

class ResourcesScreen extends StatefulWidget {
  final bool showBackButton;
  const ResourcesScreen({super.key, this.showBackButton = true});

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  final ResourceService _resourceService = ResourceService();
  
  List<dynamic> _allResources = [];
  bool _isLoading = true;
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _fetchResources();
  }

  Future<void> _fetchResources() async {
    setState(() => _isLoading = true);
    final resources = await _resourceService.fetchResources();
    setState(() {
      _allResources = resources;
      _isLoading = false;
    });
  }

  List<dynamic> get _filteredResources {
    if (_selectedCategory == 'All') return _allResources;
    return _allResources.where((r) => r['category']?.toString().toUpperCase() == _selectedCategory.toUpperCase()).toList();
  }

  dynamic get _featuredResource {
    try {
      return _allResources.firstWhere((r) => r['is_featured'] == true);
    } catch (_) {
      return null;
    }
  }

  List<dynamic> get _meditationResources {
    return _allResources.where((r) => r['category'] == 'MEDITATION' && r['is_featured'] != true).toList();
  }

  List<dynamic> get _yogaResources {
    return _allResources.where((r) => r['category'] == 'YOGA' && r['is_featured'] != true).toList();
  }

  void _navigateToPlayer(dynamic resource) {
    String fileUrl = resource['file'] ?? '';
    if (fileUrl.startsWith('/')) {
      // Remove '/api/v1' from baseUrl and append the media path
      fileUrl = '${ApiConstants.baseUrl.replaceAll('/api/v1', '')}$fileUrl';
    }

    if (resource['type'] == 'VIDEO') {
      context.push('/video-player?title=${Uri.encodeComponent(resource['title'])}&videoUrl=${Uri.encodeComponent(fileUrl)}');
    } else {
      context.push('/audio-player?title=${Uri.encodeComponent(resource['title'])}&subtitle=${Uri.encodeComponent(resource['subtitle'] ?? '')}&audioUrl=${Uri.encodeComponent(fileUrl)}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: widget.showBackButton ? IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ) : null,
        title: Text('Resource', style: AppTextStyles.heading4),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: _fetchResources,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('EXPLORE & LEARN', style: AppTextStyles.labelSmall),
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
                          prefixIcon: const Icon(
                            Icons.search,
                            color: AppColors.textGray,
                          ),
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
                            _buildFilterChip('All'),
                            const SizedBox(width: 8),
                            _buildFilterChip('Meditation'),
                            const SizedBox(width: 8),
                            _buildFilterChip('Yoga'),
                            const SizedBox(width: 8),
                            _buildFilterChip('Articles'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      if (_selectedCategory == 'All' || _selectedCategory.toUpperCase() == 'MEDITATION') ...[
                        if (_featuredResource != null) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Featured Today', style: AppTextStyles.heading4),
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
                          _buildFeaturedCard(_featuredResource),
                          const SizedBox(height: 24),
                        ],

                        if (_meditationResources.isNotEmpty) ...[
                          Text('Meditation Audio', style: AppTextStyles.heading4),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              if (_meditationResources.isNotEmpty)
                                Expanded(child: _buildMeditationCard(_meditationResources[0], AppColors.accentGreen)),
                              const SizedBox(width: 12),
                              if (_meditationResources.length > 1)
                                Expanded(child: _buildMeditationCard(_meditationResources[1], AppColors.primaryTeal)),
                              if (_meditationResources.length <= 1)
                                Expanded(child: Container()),
                            ],
                          ),
                          const SizedBox(height: 24),
                        ],
                      ],

                      if (_selectedCategory == 'All' || _selectedCategory.toUpperCase() == 'YOGA') ...[
                        if (_yogaResources.isNotEmpty) ...[
                          Text('Yoga & Movement', style: AppTextStyles.heading4),
                          const SizedBox(height: 16),
                          ..._yogaResources.map((resource) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _buildYogaItem(resource),
                            );
                          }).toList(),
                        ],
                      ],
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedCategory == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = label;
        });
      },
      child: Container(
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
      ),
    );
  }

  Widget _buildFeaturedCard(dynamic resource) {
    final title = resource['title'] ?? '';
    final subtitle = resource['subtitle'] ?? '';
    final duration = resource['duration_minutes'] != null ? '${resource['duration_minutes']} min' : '';
    
    return GestureDetector(
      onTap: () => _navigateToPlayer(resource),
      child: Container(
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
                      Icon(resource['type'] == 'VIDEO' ? Icons.play_circle : Icons.music_note, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        resource['category'] == 'YOGA' ? 'Yoga Video' : 'Meditation Audio',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: AppTextStyles.heading4,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$duration · $subtitle',
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
    );
  }

  Widget _buildMeditationCard(dynamic resource, Color color) {
    final title = resource['title'] ?? '';
    final level = _formatLevel(resource['difficulty_level']);
    final duration = resource['duration_minutes'] != null ? '${resource['duration_minutes']} min' : '';

    return GestureDetector(
      onTap: () => _navigateToPlayer(resource),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
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
            Text(title, style: AppTextStyles.heading5.copyWith(fontSize: 14)),
            const SizedBox(height: 4),
            Text(duration, style: AppTextStyles.bodySmall),
            const SizedBox(height: 12),
            const Icon(Icons.play_circle_outline, size: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildYogaItem(dynamic resource) {
    final title = resource['title'] ?? '';
    final subtitle = resource['subtitle'] ?? '';
    final duration = resource['duration_minutes'] != null ? '${resource['duration_minutes']}m' : '';
    
    // Determine emoji/thumbnail based on title as requested to keep UI identical to screenshot
    String emoji = '🧘';
    String? thumbnailPath;
    if (title.contains('Emotional Release')) {
      thumbnailPath = 'assets/images/Yoga for Emotional Release thamnail.png';
    } else if (title.contains('Breathwork')) {
      emoji = '🌬️';
    } else if (title.contains('Stress Recovery')) {
      emoji = '💪';
    }

    return GestureDetector(
      onTap: () => _navigateToPlayer(resource),
      child: Container(
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
              child: thumbnailPath != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        thumbnailPath,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Center(
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
                  Text(subtitle, style: AppTextStyles.bodySmall),
                ],
              ),
            ),
            Text(
              duration,
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.textGray),
            ),
          ],
        ),
      ),
    );
  }

  String _formatLevel(String? level) {
    if (level == null || level.isEmpty) return 'Beginner';
    return level[0].toUpperCase() + level.substring(1).toLowerCase();
  }
}
