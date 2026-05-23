import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProgressTrackerScreen extends StatelessWidget {
  const ProgressTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
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
                                const Text(
                                  '4 Day',
                                  style: TextStyle(
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
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '8',
                                      style: TextStyle(
                                        color: Color(0xFF0B191D),
                                        fontSize: 20,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Text(
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
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '2',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Text(
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
                        children: [
                          _buildCompetencyProgress(
                            'Self Perception',
                            '4/30',
                            4 / 30,
                            const Color(0xFFE8A54B),
                            const Color(0xFF855400),
                          ),
                          const SizedBox(height: 16),
                          _buildCompetencyProgress(
                            'Interpersonal',
                            '0/30',
                            0,
                            const Color(0xFF3D8C8C),
                            const Color(0xFF3D8C8C),
                          ),
                          const SizedBox(height: 16),
                          _buildCompetencyProgress(
                            'Stress Management',
                            '2/70',
                            2 / 70,
                            const Color(0xFFE07B6A),
                            const Color(0xFFE07B6A),
                          ),
                          const SizedBox(height: 16),
                          _buildCompetencyProgress(
                            'Spirituality',
                            '0/30',
                            0,
                            const Color(0xFF7B68EE),
                            const Color(0xFF7B68EE),
                          ),
                          const SizedBox(height: 16),
                          _buildCompetencyProgress(
                            'Executive Function',
                            '0/30',
                            0,
                            const Color(0xFF4A90D9),
                            const Color(0xFF4A90D9),
                          ),
                          const SizedBox(height: 16),
                          _buildCompetencyProgress(
                            'Decision Making',
                            '0/30',
                            0,
                            const Color(0xFF4CAF7D),
                            const Color(0xFF4CAF7D),
                          ),
                        ],
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
                        children: [
                          _buildBadge('🏅', 'First Step', false),
                          const SizedBox(width: 8),
                          _buildBadge('🔥', 'On Fire', true),
                          const SizedBox(width: 8),
                          _buildBadge('🧠', 'Deep Diver', false, locked: true),
                          const SizedBox(width: 8),
                          _buildBadge('⭐', '30 Days', false, locked: true),
                        ],
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
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF0B191D),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
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
          ),
        ],
      ),
    );
  }
}
