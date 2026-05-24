import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AbilitiesUnderCompetencyScreen extends StatefulWidget {
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
  State<AbilitiesUnderCompetencyScreen> createState() =>
      _AbilitiesUnderCompetencyScreenState();
}

class _AbilitiesUnderCompetencyScreenState
    extends State<AbilitiesUnderCompetencyScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _headerImageSlideAnimation;
  late Animation<Offset> _headerTextSlideAnimation;
  late List<Animation<Offset>> _abilityCardAnimations;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Very subtle upward slide with smooth fade
    _headerImageSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.02),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _headerTextSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.02),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Create 5 ability card animations with subtle upward movement
    _abilityCardAnimations = List.generate(5, (index) {
      return Tween<Offset>(
        begin: const Offset(0, 0.02),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    });

    // Smooth, slow fade animation
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Parse color from hex string - handle both with and without #
    String cleanColor = widget.competencyColor.replaceFirst('#', '');
    Color primaryColor = Color(int.parse('FF$cleanColor', radix: 16));

    // Debug print
    print(
      'AbilitiesUnderCompetencyScreen - competencyId: ${widget.competencyId}',
    );
    print(
      'AbilitiesUnderCompetencyScreen - competencyName: ${widget.competencyName}',
    );
    print(
      'AbilitiesUnderCompetencyScreen - competencyColor: ${widget.competencyColor}',
    );

    // Get competency-specific data
    final competencyData = _getCompetencyData(widget.competencyId);
    print(
      'AbilitiesUnderCompetencyScreen - abilities count: ${competencyData['abilities'].length}',
    );

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

              // Header Image/Icon - Slides from left
              SlideTransition(
                position: _headerImageSlideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Center(
                    child: competencyData['headerImage'] != null
                        ? Image.asset(
                            competencyData['headerImage'],
                            width: 120,
                            height: 120,
                            fit: BoxFit.contain,
                          )
                        : Text(
                            competencyData['headerEmoji'],
                            style: const TextStyle(fontSize: 80),
                          ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Header Section - Slides from right
              SlideTransition(
                position: _headerTextSlideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '✦ ${widget.competencyName.toUpperCase()}',
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
                          height: 1.43,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Abilities List with alternating animations
              ...List.generate(competencyData['abilities'].length, (index) {
                final ability = competencyData['abilities'][index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: SlideTransition(
                    position: _abilityCardAnimations[index],
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: _buildAbilityCard(
                        emoji: ability['emoji'],
                        title: ability['title'],
                        description: ability['description'],
                        status: ability['status'],
                        isActive: ability['isActive'],
                        primaryColor: primaryColor,
                        backgroundImage: competencyData['backgroundImage'],
                      ),
                    ),
                  ),
                );
              }),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> _getCompetencyData(String competencyId) {
    switch (competencyId) {
      case 'self-management':
        return {
          'headerEmoji': '🧠',
          'headerImage': null,
          'backgroundImage':
              'assets/images/Self-management element card background.png',
          'abilities': [
            {
              'emoji': '🧠',
              'title': 'Emotional Awareness',
              'description': 'Notice and name your emotions in real time.',
              'status': 'Day 1/30',
              'isActive': true,
            },
            {
              'emoji': '🚧',
              'title': 'Boundary Awareness',
              'description': 'Know your limits and say no without guilt.',
              'status': 'Not started',
              'isActive': false,
            },
            {
              'emoji': '💪',
              'title': 'Self-Confidence',
              'description': 'Trust your abilities under pressure.',
              'status': 'Not started',
              'isActive': false,
            },
            {
              'emoji': '🌱',
              'title': 'Self-Actualization',
              'description': 'Move toward your best, not just survive.',
              'status': 'Not started',
              'isActive': false,
            },
            {
              'emoji': '🦅',
              'title': 'Independence',
              'description':
                  'Decide for yourself without over-relying on approval.',
              'status': 'Not started',
              'isActive': false,
            },
          ],
        };

      case 'stress-management':
        return {
          'headerEmoji': '🌊',
          'headerImage': null,
          'backgroundImage':
              'assets/images/stress management element card background.png',
          'abilities': [
            {
              'emoji': '🧊',
              'title': 'Stress Tolerance',
              'description': 'Stay functional when pressure is high.',
              'status': 'Not started',
              'isActive': false,
            },
            {
              'emoji': '🧠',
              'title': 'Cognitive Flexibility',
              'description': 'Adapt your thinking when situations change.',
              'status': 'Not started',
              'isActive': false,
            },
            {
              'emoji': '⚖️',
              'title': 'Emotional Regulation',
              'description': 'Shape and respond to emotions over time.',
              'status': 'Not started',
              'isActive': false,
            },
            {
              'emoji': '😊',
              'title': 'Optimism',
              'description': 'Find realistic hope even in hard times.',
              'status': 'Not started',
              'isActive': false,
            },
            {
              'emoji': '🤝',
              'title': 'Social Resources',
              'description': 'Track and manage what drains or fuels you.',
              'status': 'Not started',
              'isActive': false,
            },
          ],
        };

      case 'interpersonal':
        return {
          'headerEmoji': '🤝',
          'headerImage': null,
          'backgroundImage':
              'assets/images/Interpersonal Management Element card background.png',
          'abilities': [
            {
              'emoji': '💗',
              'title': 'Empathy',
              'description': 'Understand others\' feelings accurately.',
              'status': 'Not started',
              'isActive': false,
            },
            {
              'emoji': '😊',
              'title': 'Verbal Expression',
              'description': 'Say what you mean clearly.',
              'status': 'Not started',
              'isActive': false,
            },
            {
              'emoji': '🔄',
              'title': 'Non-verbal Communication',
              'description': 'Align your body language with your message.',
              'status': 'Not started',
              'isActive': false,
            },
            {
              'emoji': '💪',
              'title': 'Assertiveness',
              'description': 'Ask for what you need without aggression.',
              'status': 'Not started',
              'isActive': false,
            },
            {
              'emoji': '🧘',
              'title': 'Conflict Management',
              'description': 'Stay steady and solution-focused in conflict.',
              'status': 'Not started',
              'isActive': false,
            },
          ],
        };

      case 'spirit-&-energy':
      case 'spirit-':
      case 'spirit':
      case 'spirit-management':
        return {
          'headerEmoji': '⚡',
          'headerImage': null,
          'backgroundImage':
              'assets/images/spirit and energy element card background.png',
          'abilities': [
            {
              'emoji': '🙏',
              'title': 'Belief Influence',
              'description':
                  'Examine beliefs that shape your sense of meaning.',
              'status': 'Not started',
              'isActive': false,
            },
            {
              'emoji': '🔍',
              'title': 'Clarity',
              'description': 'Get clear on what you want in life and work.',
              'status': 'Not started',
              'isActive': false,
            },
            {
              'emoji': '💚',
              'title': 'Energy Awareness',
              'description': 'Pursue your highest potential consistently.',
              'status': 'Not started',
              'isActive': false,
            },
            {
              'emoji': '🏘️',
              'title': 'Community Building',
              'description': 'Create belonging and connection around you.',
              'status': 'Not started',
              'isActive': false,
            },
            {
              'emoji': '🌍',
              'title': 'Meaning Making',
              'description': 'Build and use your support network wisely.',
              'status': 'Not started',
              'isActive': false,
            },
          ],
        };

      case 'decision-making':
      case 'decision':
        return {
          'headerEmoji': '🎯',
          'headerImage': null,
          'backgroundImage':
              'assets/images/decision-making element card background.png',
          'abilities': [
            {
              'emoji': '🧠',
              'title': 'Processing Speed',
              'description': 'Analyze situations clearly before acting.',
              'status': 'Not started',
              'isActive': false,
            },
            {
              'emoji': '🛑',
              'title': 'Impulse Control',
              'description': 'Understand risk and make informed choices.',
              'status': 'Not started',
              'isActive': false,
            },
            {
              'emoji': '🔬',
              'title': 'Reality Testing',
              'description': 'See situations from multiple angles.',
              'status': 'Not started',
              'isActive': false,
            },
            {
              'emoji': '⚖️',
              'title': 'Abstraction',
              'description': 'Make decisions aligned with what matters to you.',
              'status': 'Not started',
              'isActive': false,
            },
            {
              'emoji': '💡',
              'title': 'Problem Solving',
              'description': 'Work through challenges step by step.',
              'status': 'Not started',
              'isActive': false,
            },
          ],
        };

      case 'executive-function':
      case 'executive':
        return {
          'headerEmoji': '🧭',
          'headerImage': null,
          'backgroundImage':
              'assets/images/executive function element card background.png',
          'abilities': [
            {
              'emoji': '📋',
              'title': 'Planning',
              'description': 'Organize your time and tasks effectively.',
              'status': 'Not started',
              'isActive': false,
            },
            {
              'emoji': '🎯',
              'title': 'Prioritizing',
              'description': 'Stay on task despite distraction.',
              'status': 'Not started',
              'isActive': false,
            },
            {
              'emoji': '💪',
              'title': 'Motivation',
              'description': 'Make sound decisions under pressure.',
              'status': 'Not started',
              'isActive': false,
            },
            {
              'emoji': '🎯',
              'title': 'Attention Span',
              'description': 'Set goals that actually move you forward.',
              'status': 'Not started',
              'isActive': false,
            },
            {
              'emoji': '📦',
              'title': 'Organization',
              'description': 'Complete what you start, reliably.',
              'status': 'Not started',
              'isActive': false,
            },
          ],
        };

      default:
        return {
          'headerEmoji': '🧠',
          'headerImage': null,
          'backgroundImage':
              'assets/images/Self-management element card background.png',
          'abilities': [],
        };
    }
  }

  Widget _buildAbilityCard({
    required String emoji,
    required String title,
    required String description,
    required String status,
    required bool isActive,
    required Color primaryColor,
    required String backgroundImage,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
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
