import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/services/notification_service.dart';
import '../../core/services/profile_service.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  int selectedMinutes = 60;
  String selectedPace = 'MEDIUM';
  bool isLoading = true;
  final ProfileService _profileService = ProfileService();

  final List<int> goalOptions = [15, 30, 45, 60, 90, 120];
  static const List<Map<String, dynamic>> _paceOptions = [
    {
      'code': 'LOW',
      'emoji': '🌱',
      'label': 'LOW',
      'title': '1 ability per day',
      'subtitle': '≈ 5 minutes daily',
      'color': Color(0xFF4CAF7D),
    },
    {
      'code': 'MEDIUM',
      'emoji': '🔥',
      'label': 'MEDIUM',
      'title': '2 abilities per day',
      'subtitle': '≈ 10 minutes daily',
      'color': Color(0xFF50A8C0),
    },
    {
      'code': 'HIGH',
      'emoji': '🚀',
      'label': 'HIGH',
      'title': '3 abilities per day',
      'subtitle': '≈ 15 minutes daily',
      'color': Color(0xFFE07B6A),
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadGoal();
  }

  Future<void> _loadGoal() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPace = prefs.getString('selected_growth_plan');
    try {
      final profile = await _profileService.getProfile();
      if (mounted) {
        final remotePace = (profile['growth_plan'] ?? savedPace ?? 'MEDIUM')
            .toString()
            .toUpperCase();
        setState(() {
          selectedMinutes = profile['daily_goal_minutes'] ?? 60;
          selectedPace = ['LOW', 'MEDIUM', 'HIGH'].contains(remotePace)
              ? remotePace
              : 'MEDIUM';
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          if (savedPace != null && ['LOW', 'MEDIUM', 'HIGH'].contains(savedPace)) {
            selectedPace = savedPace;
          }
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(color: Color(0x14073B4B), blurRadius: 4),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFF0B191D),
                        size: 20,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Daily Goal',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF0B191D),
                        fontSize: 18,
                        fontFamily: 'Archivo',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Description
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F9FF),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF095A70).withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('🎯', style: TextStyle(fontSize: 24)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Set Your Daily Goal',
                                  style: TextStyle(
                                    color: Color(0xFF095A70),
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Choose how much time you want to dedicate to your emotional growth each day.',
                                  style: TextStyle(
                                    color: const Color(
                                      0xFF095A70,
                                    ).withValues(alpha: 0.8),
                                    fontSize: 14,
                                    fontFamily: 'Inter',
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Current Goal Display
                    Center(
                      child: Column(
                        children: [
                          const Text(
                            'Your Daily Goal',
                            style: TextStyle(
                              color: Color(0xFF637275),
                              fontSize: 14,
                              fontFamily: 'Inter',
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '$selectedMinutes',
                            style: const TextStyle(
                              color: Color(0xFF095A70),
                              fontSize: 64,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Text(
                            'minutes per day',
                            style: TextStyle(
                              color: Color(0xFF637275),
                              fontSize: 16,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Growth Pace Options (Abilities per day)
                    const Text(
                      'Growth Pace (Abilities per Day)',
                      style: TextStyle(
                        color: Color(0xFF0B191D),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ..._paceOptions.map((option) {
                      final code = option['code'] as String;
                      final color = option['color'] as Color;
                      final isSelected = selectedPace == code;
                      return GestureDetector(
                        onTap: () => setState(() => selectedPace = code),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? color.withValues(alpha: 0.08)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected ? color : const Color(0xFFE2E8F0),
                              width: isSelected ? 1.8 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                option['emoji'] as String,
                                style: const TextStyle(fontSize: 22),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      option['label'] as String,
                                      style: TextStyle(
                                        color: color,
                                        fontSize: 11,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.6,
                                      ),
                                    ),
                                    Text(
                                      option['title'] as String,
                                      style: const TextStyle(
                                        color: Color(0xFF0B191D),
                                        fontSize: 15,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      option['subtitle'] as String,
                                      style: const TextStyle(
                                        color: Color(0xFF637275),
                                        fontSize: 12,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                Icon(Icons.check_circle, color: color, size: 22),
                            ],
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 6),
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => context.push('/ability-order'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F9FF),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF095A70).withValues(alpha: 0.2),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.tune_rounded,
                              color: Color(0xFF095A70),
                              size: 20,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Pick which abilities you want to finish first',
                                style: TextStyle(
                                  color: Color(0xFF095A70),
                                  fontSize: 13.5,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                              color: Color(0xFF095A70),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Goal Options
                    const Text(
                      'Choose Duration',
                      style: TextStyle(
                        color: Color(0xFF0B191D),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(color: Color(0x14073B4B), blurRadius: 4),
                        ],
                      ),
                      child: Column(
                        children: goalOptions.asMap().entries.map((entry) {
                          final index = entry.key;
                          final minutes = entry.value;
                          final isLast = index == goalOptions.length - 1;
                          final isSelected = selectedMinutes == minutes;

                          String label;
                          String description;

                          if (minutes == 15) {
                            label = '15 min';
                            description = 'Quick daily check-in';
                          } else if (minutes == 30) {
                            label = '30 min';
                            description = 'Light practice';
                          } else if (minutes == 45) {
                            label = '45 min';
                            description = 'Moderate commitment';
                          } else if (minutes == 60) {
                            label = '60 min';
                            description = 'Recommended';
                          } else if (minutes == 90) {
                            label = '90 min';
                            description = 'Deep practice';
                          } else {
                            label = '120 min';
                            description = 'Intensive growth';
                          }

                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedMinutes = minutes;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? const Color(
                                            0xFF095A70,
                                          ).withValues(alpha: 0.05)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: isSelected
                                                  ? const Color(0xFF095A70)
                                                  : const Color(0xFFF8FAFC),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Center(
                                              child: Text(
                                                '⏱️',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: isSelected
                                                      ? Colors.white
                                                      : const Color(0xFF637275),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                label,
                                                style: TextStyle(
                                                  color: const Color(
                                                    0xFF0B191D,
                                                  ),
                                                  fontSize: 16,
                                                  fontFamily: 'Inter',
                                                  fontWeight: isSelected
                                                      ? FontWeight.w600
                                                      : FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                description,
                                                style: const TextStyle(
                                                  color: Color(0xFF637275),
                                                  fontSize: 12,
                                                  fontFamily: 'Inter',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      if (isSelected)
                                        const Icon(
                                          Icons.check_circle,
                                          color: Color(0xFF095A70),
                                          size: 24,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              if (!isLast)
                                Container(
                                  height: 1,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  color: Colors.black.withValues(alpha: 0.04),
                                ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Save Button
            Container(
              padding: const EdgeInsets.all(26),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isLoading ? null : () async {
                    setState(() => isLoading = true);
                    try {
                      await _profileService.updateProfile({
                        'daily_goal_minutes': selectedMinutes,
                        'growth_plan': selectedPace,
                      });
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString('selected_growth_plan', selectedPace);
                      final nudgeDays = selectedPace == 'HIGH'
                          ? 1
                          : (selectedPace == 'MEDIUM' ? 2 : 3);
                      await NotificationService().scheduleInactivityNudge(nudgeDays);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Goal & growth pace updated'),
                            backgroundColor: Color(0xFF095A70),
                          ),
                        );
                        context.pop();
                      }
                    } catch (e) {
                      if (context.mounted) {
                        setState(() => isLoading = false);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Failed to update goal')),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF095A70),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: isLoading 
                    ? const SizedBox(
                        height: 24, 
                        width: 24, 
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                      )
                    : const Text(
                    'Save Goal',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
