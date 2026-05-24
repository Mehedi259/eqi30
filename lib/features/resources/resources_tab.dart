import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResourcesTab extends StatefulWidget {
  const ResourcesTab({super.key});

  @override
  State<ResourcesTab> createState() => _ResourcesTabState();
}

class _ResourcesTabState extends State<ResourcesTab> {
  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All',
    'Meditation',
    'Yoga',
    'Articles',
    'Journeys',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 26,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Icon(Icons.arrow_back, size: 16),
                      ),
                    ),
                    const Text(
                      'Resource',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF0B191D),
                        fontSize: 18,
                        fontFamily: 'Archivo',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 24),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title Section
                    const Text(
                      'EXPLORE & LEARN',
                      style: TextStyle(
                        color: Color(0xFF095A70),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const Text(
                      'Resource Hub',
                      style: TextStyle(
                        color: Color(0xFF0B191D),
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Text(
                      'Meditations · Yoga · Articles · Journeys',
                      style: TextStyle(
                        color: Color(0x990B1F3A),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Search Bar
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2FCFF),
                        border: Border.all(color: const Color(0x19637275)),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.search,
                            color: Color(0xFF637275),
                            size: 20,
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Search resources...',
                            style: TextStyle(
                              color: Color(0xFF637275),
                              fontSize: 14,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Category Filters
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _categories.map((category) {
                          final isSelected = _selectedCategory == category;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedCategory = category;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF095A70)
                                      : const Color(0xFFF3FCFF),
                                  border: Border.all(
                                    color: isSelected
                                        ? Colors.transparent
                                        : const Color(0x19637275),
                                  ),
                                  borderRadius: BorderRadius.circular(9999),
                                  boxShadow: isSelected
                                      ? [
                                          const BoxShadow(
                                            color: Color(0x0C000000),
                                            blurRadius: 2,
                                            offset: Offset(0, 1),
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Text(
                                  category,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xFF637275),
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Featured Today
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Featured Today',
                          style: TextStyle(
                            color: Color(0xFF0B191D),
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'See all',
                          style: TextStyle(
                            color: Color(0xFF095A70),
                            fontSize: 12,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Featured Card
                    GestureDetector(
                      onTap: () {
                        context.push(
                          '/audio-player?title=Morning Calm — Body Scan&subtitle=Audio Guide',
                        );
                      },
                      child: _buildFeaturedCard(),
                    ),

                    const SizedBox(height: 24),

                    // Meditation Audio Section
                    const Text(
                      'Meditation Audio',
                      style: TextStyle(
                        color: Color(0xFF0B191D),
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 12),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.push(
                                '/audio-player?title=Morning Body Scan&subtitle=Guided Meditation',
                              );
                            },
                            child: _buildMeditationCard(
                              emoji: '🌿',
                              title: 'Morning Body\nScan',
                              duration: '10 min',
                              level: 'Beginner',
                              levelColor: const Color(0xFF3CA440),
                              gradient: const [
                                Color(0x194CAF50),
                                Color(0x004CAF50),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: () {
                              context.push(
                                '/audio-player?title=Stress Release Flow&subtitle=Guided Meditation',
                              );
                            },
                            child: _buildMeditationCard(
                              emoji: '🌊',
                              title: 'Stress Release\nFlow',
                              duration: '15 min',
                              level: 'Intermediate',
                              levelColor: const Color(0xFF238EAB),
                              gradient: const [
                                Color(0x33627BB0),
                                Color(0x008EA2CE),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: () {
                              context.push(
                                '/audio-player?title=Evening Wind Down&subtitle=Guided Meditation',
                              );
                            },
                            child: _buildMeditationCard(
                              emoji: '🌞',
                              title: 'Evening Wind\nDown',
                              duration: '20 min',
                              level: 'Beginner',
                              levelColor: const Color(0xFFD87940),
                              gradient: const [
                                Color(0x33FFDCC1),
                                Color(0x00FFDCC1),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Yoga & Movement Section
                    const Text(
                      'Yoga & Movement',
                      style: TextStyle(
                        color: Color(0xFF0B191D),
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 12),

                    GestureDetector(
                      onTap: () {
                        context.push(
                          '/video-player?title=Yoga for Emotional Release',
                        );
                      },
                      child: _buildYogaItem(
                        emoji: '🧘',
                        title: 'Yoga for Emotional Release',
                        subtitle: 'Video Guide',
                        duration: '25m',
                        bgColor: const Color(0x194CAF50),
                        borderColor: const Color(0x334CAF50),
                      ),
                    ),

                    const SizedBox(height: 12),

                    GestureDetector(
                      onTap: () {
                        context.push(
                          '/audio-player?title=Breathwork & Pranayama&subtitle=Guided Session',
                        );
                      },
                      child: _buildYogaItem(
                        emoji: '🌬️',
                        title: 'Breathwork & Pranayama',
                        subtitle: 'Guided Session',
                        duration: '15m',
                        bgColor: const Color(0x4CD6E3FF),
                        borderColor: const Color(0x7FD6E3FF),
                      ),
                    ),

                    const SizedBox(height: 12),

                    GestureDetector(
                      onTap: () {
                        context.push(
                          '/video-player?title=Yoga for Stress Recovery',
                        );
                      },
                      child: _buildYogaItem(
                        emoji: '💪',
                        title: 'Yoga for Stress Recovery',
                        subtitle: 'Video Guide',
                        duration: '30m',
                        bgColor: const Color(0x4CFFDCC1),
                        borderColor: const Color(0x7FFFDCC1),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0x0A095A70),
        border: Border.all(color: const Color(0x14095A70)),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x07000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.80),
              border: Border.all(color: const Color(0x66CBEDCB)),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: const Text(
              '🎵 Meditation Audio',
              style: TextStyle(
                color: Color(0xFF0B191D),
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Morning Calm',
                      style: TextStyle(
                        color: Color(0xFF0B191D),
                        fontSize: 24,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '— Body Scan',
                      style: TextStyle(
                        color: Color(0xCC0B1F3A),
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '12 min · Audio Guide',
                      style: TextStyle(
                        color: Color(0xB20B1F3A),
                        fontSize: 14,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: Color(0xFF095A70),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMeditationCard({
    required String emoji,
    required String title,
    required String duration,
    required String level,
    required Color levelColor,
    required List<Color> gradient,
  }) {
    return Container(
      width: 169,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradient,
        ),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 24)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: levelColor.withValues(alpha: 0.3)),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  level,
                  style: TextStyle(
                    color: levelColor,
                    fontSize: 10,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF0B191D),
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              height: 1.38,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                duration,
                style: const TextStyle(
                  color: Color(0x990B1F3A),
                  fontSize: 12,
                  fontFamily: 'Inter',
                ),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F3F6),
                  border: Border.all(color: const Color(0x4CC4C6CE)),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow,
                  size: 16,
                  color: Color(0xFF0B191D),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildYogaItem({
    required String emoji,
    required String title,
    required String subtitle,
    required String duration,
    required Color bgColor,
    required Color borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: bgColor,
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 20)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF0B191D),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0x990B1F3A),
                    fontSize: 12,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFEFEDF0),
              border: Border.all(color: const Color(0x33C4C6CE)),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Text(
              duration,
              style: const TextStyle(
                color: Color(0xCC0B1F3A),
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
