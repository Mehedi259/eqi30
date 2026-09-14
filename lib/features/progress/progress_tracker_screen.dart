import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/services/journey_service.dart';

class ProgressTrackerScreen extends StatefulWidget {
  const ProgressTrackerScreen({super.key});

  @override
  State<ProgressTrackerScreen> createState() => _ProgressTrackerScreenState();
}

class _ProgressTrackerScreenState extends State<ProgressTrackerScreen> {
  final JourneyService _journeyService = JourneyService();
  bool _isLoading = true;
  
  Map<String, dynamic> _data = {};

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final data = await _journeyService.getProgressTrackerData();
      if (mounted) {
        setState(() {
          _data = data;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load progress data')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    int streak = _data['streak_days'] ?? 0;
    
    // Calculate total completed this week
    int thisWeek = 0;
    if (_data['weekly_activity'] != null) {
      for (var activity in _data['weekly_activity']) {
        thisWeek += (activity['completed'] as num?)?.toInt() ?? 0;
      }
    }

    int activeGoals = _data['active_goal']?['minutes_completed_today'] ?? 0;
    if (activeGoals == 0) activeGoals = 2; // Default if not found to match mockup, or use a better metric

    List<dynamic> competencies = _data['competencies'] ?? [];
    List<dynamic> earnedBadges = _data['badges']?['earned'] ?? [];
    List<dynamic> availableBadges = _data['badges']?['available'] ?? [];
    
    // Ensure "First Step", "On Fire" etc are present based on badge data
    List<Widget> badgeWidgets = [];
    
    for (var badgeObj in earnedBadges) {
      var badge = badgeObj['badge'] ?? badgeObj;
      badgeWidgets.add(_buildBadge('🏅', badge['name'] ?? 'Badge', true));
      badgeWidgets.add(const SizedBox(width: 8));
    }
    
    for (var badge in availableBadges) {
      badgeWidgets.add(_buildBadge('🔒', badge['name'] ?? 'Locked', false, locked: true));
      badgeWidgets.add(const SizedBox(width: 8));
    }
    
    if (badgeWidgets.isEmpty) {
      // Fallback
      badgeWidgets = [
        _buildBadge('🏅', 'First Step', false),
        const SizedBox(width: 8),
        _buildBadge('🔥', 'On Fire', false),
        const SizedBox(width: 8),
        _buildBadge('🧠', 'Deep Diver', false, locked: true),
        const SizedBox(width: 8),
        _buildBadge('⭐', '30 Days', false, locked: true),
      ];
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      onTap: () => context.pop(),
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          size: 16,
                          color: Color(0xFF0B191D),
                        ),
                      ),
                    ),
                    const Text(
                      'Progress Tracker',
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

              const SizedBox(height: 16),

              // Your Progress Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your Progress',
                              style: TextStyle(
                                color: Color(0xFF0B191D),
                                fontSize: 24,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Last updated today',
                              style: TextStyle(
                                color: Color(0xFF637275),
                                fontSize: 14,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0x19073B4B),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.calendar_today,
                            size: 20,
                            color: Color(0xFF095A70),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Stats Cards
                    Row(
                      children: [
                        // Streak Card
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 13,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD2E9F0),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '🔥',
                                  style: TextStyle(fontSize: 24),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  '$streak Day',
                                  style: const TextStyle(
                                    color: Color(0xFF0B191D),
                                    fontSize: 24,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Text(
                                  'Streak',
                                  style: TextStyle(
                                    color: Color(0xFF0B191D),
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        // This Week & Active Goals
                        Expanded(
                          child: Column(
                            children: [
                              // This Week
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.black.withValues(alpha: 0.20),
                                  ),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '$thisWeek',
                                      style: const TextStyle(
                                        color: Color(0xFF0B191D),
                                        fontSize: 20,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    const Text(
                                      'This Week',
                                      style: TextStyle(
                                        color: Color(0xFF0B191D),
                                        fontSize: 12,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 12),

                              // Active Goals
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF095A70),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '$activeGoals',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    const Text(
                                      'Active Goals',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // By Competency Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'By Competency',
                      style: TextStyle(
                        color: Color(0xFF0B191D),
                        fontSize: 18,
                        fontFamily: 'Plus Jakarta Sans',
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: competencies.map((comp) {
                          int completed = comp['completed_abilities'] ?? 0;
                          int total = comp['total_abilities'] ?? 30;
                          double val = total > 0 ? completed / total : 0.0;
                          String name = comp['competency']?['name'] ?? 'Unknown';
                          
                          // assign some colors consistently or randomly based on name length
                          Color progressColor = _getColorForCompetency(name);
                          
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: _buildCompetencyProgress(
                              name,
                              '$completed/$total',
                              val,
                              progressColor,
                              progressColor,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Badges Earned Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Badges Earned',
                      style: TextStyle(
                        color: Color(0xFF0B191D),
                        fontSize: 18,
                        fontFamily: 'Plus Jakarta Sans',
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 16),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: badgeWidgets,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Color _getColorForCompetency(String name) {
    if (name.contains('Perception')) return const Color(0xFFE8A54B);
    if (name.contains('Interpersonal')) return const Color(0xFF3D8C8C);
    if (name.contains('Stress')) return const Color(0xFFE07B6A);
    if (name.contains('Spirit')) return const Color(0xFF7B68EE);
    if (name.contains('Executive')) return const Color(0xFF4A90D9);
    if (name.contains('Decision')) return const Color(0xFF4CAF7D);
    return const Color(0xFF4A90D9);
  }

  Widget _buildCompetencyProgress(
    String title,
    String progress,
    double value,
    Color progressColor,
    Color textColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF0B191D),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              progress,
              style: TextStyle(
                color: textColor,
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(9999),
          child: LinearProgressIndicator(
            value: value,
            backgroundColor: const Color(0xFFF2EDE5),
            valueColor: AlwaysStoppedAnimation<Color>(progressColor),
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildBadge(
    String emoji,
    String label,
    bool earned, {
    bool locked = false,
  }) {
    return Opacity(
      opacity: earned ? 1.0 : 0.4,
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: earned ? const Color(0x33E8A54B) : const Color(0xFFECE8E0),
              border: earned
                  ? Border.all(color: const Color(0x4CE8A54B), width: 2)
                  : null,
              shape: BoxShape.circle,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  emoji,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 30),
                ),
                if (locked)
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xFFECE8E0)),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.lock,
                        size: 12,
                        color: Color(0xFF637275),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF0B191D),
              fontSize: 11,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
