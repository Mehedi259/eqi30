import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AbilitiesUnderCompetencyScreen extends StatelessWidget {
  final String competencyId;
  final String competencyName;
  final String competencyColor;

  const AbilitiesUnderCompetencyScreen({
    super.key,
    required this.competencyId,
    required this.competencyName,
    required this.competencyColor,
  });

  @override
  Widget build(BuildContext context) {
    // Parse color from hex string - handle both with and without #
    String cleanColor = competencyColor.replaceFirst('#', '');
    Color primaryColor = Color(int.parse('FF$cleanColor', radix: 16));

    return Scaffold(
      backgroundColor: const Color(0xFFFBFEFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBFEFF),
        elevation: 0,
        leading: IconButton(
          icon: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.10),
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(Icons.arrow_back, size: 16, color: Colors.black),
          ),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Abilities Under Competency',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF0B191D),
            fontSize: 18,
            fontFamily: 'Archivo',
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              // Header Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '✦ ${competencyName.toUpperCase()}',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 1.50,
                      letterSpacing: 1.10,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '5 Abilities to Build',
                    style: TextStyle(
                      color: Color(0xFF0B191D),
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      height: 1.33,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Each ability is a focused 30–60 day micro-skill journey. Start with one.',
                    style: TextStyle(
                      color: Color(0xFF8A96A8),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1.43,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Abilities List
              _buildAbilityCard(
                emoji: '🧠',
                title: 'Emotional Awareness',
                description: 'Notice and name your emotions in real time.',
                status: 'Day 1/30',
                isActive: true,
                primaryColor: primaryColor,
              ),
              const SizedBox(height: 12),

              _buildAbilityCard(
                emoji: '🚧',
                title: 'Boundary Awareness',
                description: 'Know your limits and say no without guilt.',
                status: 'Not started',
                isActive: false,
                primaryColor: primaryColor,
              ),
              const SizedBox(height: 12),

              _buildAbilityCard(
                emoji: '💪',
                title: 'Self-Confidence',
                description: 'Trust your abilities under pressure.',
                status: 'Not started',
                isActive: false,
                primaryColor: primaryColor,
              ),
              const SizedBox(height: 12),

              _buildAbilityCard(
                emoji: '🌱',
                title: 'Self-Actualization',
                description: 'Move toward your best, not just survive.',
                status: 'Not started',
                isActive: false,
                primaryColor: primaryColor,
              ),
              const SizedBox(height: 12),

              _buildAbilityCard(
                emoji: '🦅',
                title: 'Independence',
                description:
                    'Decide for yourself without over-relying on approval.',
                status: 'Not started',
                isActive: false,
                primaryColor: primaryColor,
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAbilityCard({
    required String emoji,
    required String title,
    required String description,
    required String status,
    required bool isActive,
    required Color primaryColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 3, color: primaryColor),
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 4,
            offset: Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: ShapeDecoration(
                    color: primaryColor.withOpacity(0.15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      emoji,
                      style: const TextStyle(
                        fontSize: 32,
                        fontFamily: 'Archivo',
                        fontWeight: FontWeight.w600,
                        height: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Color(0xFF1A2B4A),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          height: 1.43,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        description,
                        style: const TextStyle(
                          color: Color(0xFF8A96A8),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 1.50,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: ShapeDecoration(
              color: isActive
                  ? const Color(0xFFDFF8FF)
                  : const Color(0xFFF1F2F4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: isActive
                    ? const Color(0xFF50A8C0)
                    : const Color(0xFF8A96A8),
                fontSize: 10,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                height: 1.60,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
