import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomJourneyOnboardingScreen extends StatefulWidget {
  const CustomJourneyOnboardingScreen({super.key});

  @override
  State<CustomJourneyOnboardingScreen> createState() =>
      _CustomJourneyOnboardingScreenState();
}

class _CustomJourneyOnboardingScreenState
    extends State<CustomJourneyOnboardingScreen>
    with SingleTickerProviderStateMixin {
  final Map<String, int?> _priorities = {
    'Self Management': 1,
    'Stress Management': 2,
    'Interpersonal Management': 3,
    'Spirit Management': 4,
    'Executive Functioning': 5,
    'Decision Making': 6,
  };

  late AnimationController _controller;
  late Animation<Offset> _headerSlideAnimation;
  late Animation<Offset> _infoBoxSlideAnimation;
  late Animation<Offset> _card1SlideAnimation;
  late Animation<Offset> _card2SlideAnimation;
  late Animation<Offset> _card3SlideAnimation;
  late Animation<Offset> _card4SlideAnimation;
  late Animation<Offset> _card5SlideAnimation;
  late Animation<Offset> _card6SlideAnimation;
  late Animation<Offset> _continueButtonSlideAnimation;
  late Animation<Offset> _backLinkSlideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _card1FadeAnimation;
  late Animation<double> _card2FadeAnimation;
  late Animation<double> _card3FadeAnimation;
  late Animation<double> _card4FadeAnimation;
  late Animation<double> _card5FadeAnimation;
  late Animation<double> _card6FadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );

    // Header animation - slides from top with fade
    _headerSlideAnimation =
        Tween<Offset>(begin: const Offset(0, -0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.4, curve: Curves.easeOutCubic),
          ),
        );

    // Info box animation - slides from right with bounce
    _infoBoxSlideAnimation =
        Tween<Offset>(begin: const Offset(0.5, 0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.1, 0.5, curve: Curves.elasticOut),
          ),
        );

    // Staggered card animations with different timings
    _card1SlideAnimation =
        Tween<Offset>(begin: const Offset(-0.3, 0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.2, 0.5, curve: Curves.easeOutCubic),
          ),
        );

    _card2SlideAnimation =
        Tween<Offset>(begin: const Offset(0.3, 0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.25, 0.55, curve: Curves.easeOutCubic),
          ),
        );

    _card3SlideAnimation =
        Tween<Offset>(begin: const Offset(-0.3, 0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.3, 0.6, curve: Curves.easeOutCubic),
          ),
        );

    _card4SlideAnimation =
        Tween<Offset>(begin: const Offset(0.3, 0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.35, 0.65, curve: Curves.easeOutCubic),
          ),
        );

    _card5SlideAnimation =
        Tween<Offset>(begin: const Offset(-0.3, 0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.4, 0.7, curve: Curves.easeOutCubic),
          ),
        );

    _card6SlideAnimation =
        Tween<Offset>(begin: const Offset(0.3, 0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.45, 0.75, curve: Curves.easeOutCubic),
          ),
        );

    // Continue button - slides from bottom with bounce
    _continueButtonSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.6, 0.9, curve: Curves.elasticOut),
          ),
        );

    // Back link - fades in at the end
    _backLinkSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.7, 1.0, curve: Curves.easeOut),
          ),
        );

    // Main fade animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    // Scale animation for cards
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    // Individual card fade animations with stagger
    _card1FadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.5, curve: Curves.easeIn),
      ),
    );

    _card2FadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.25, 0.55, curve: Curves.easeIn),
      ),
    );

    _card3FadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.6, curve: Curves.easeIn),
      ),
    );

    _card4FadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.35, 0.65, curve: Curves.easeIn),
      ),
    );

    _card5FadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.7, curve: Curves.easeIn),
      ),
    );

    _card6FadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.45, 0.75, curve: Curves.easeIn),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _setPriority(String competency, int priority) {
    setState(() {
      _priorities[competency] = priority;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAFC),
        elevation: 0,
        leading: IconButton(
          icon: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(Icons.arrow_back, size: 16, color: Colors.black),
          ),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/result-onboarding');
            }
          },
        ),
        title: const Text(
          'Custom Journey',
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
        padding: const EdgeInsets.all(26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header - Slides from left
            SlideTransition(
              position: _headerSlideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'CUSTOM JOURNEY',
                      style: TextStyle(
                        color: Color(0xFF006767),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.20,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Build your own learning path.',
                      style: TextStyle(
                        color: Color(0xFF051F1F),
                        fontSize: 24,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Tap the number to set the priority for each\ncompetency. 1 = start first.',
                      style: TextStyle(
                        color: Color(0xFF3E4948),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Info Box - Slides from right
            SlideTransition(
              position: _infoBoxSlideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0x4CFFDDB7),
                    border: Border.all(color: const Color(0xFFFFDDB7)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('💡', style: TextStyle(fontSize: 20)),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'You can always switch to your AI\nrecommended journey anytime.',
                          style: TextStyle(
                            color: Color(0xFF754900),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 1.43,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Competency Cards with staggered animations
            SlideTransition(
              position: _card1SlideAnimation,
              child: FadeTransition(
                opacity: _card1FadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: _buildCompetencyCard(
                    '🔄',
                    'Self Management',
                    'Master your reactions',
                    const Color(0xFF43BDC7),
                    const Color(0xFFD8F3F3),
                    'Self Management',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SlideTransition(
              position: _card2SlideAnimation,
              child: FadeTransition(
                opacity: _card2FadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: _buildCompetencyCard(
                    '🌊',
                    'Stress Management',
                    'Stay calm under pressure',
                    const Color(0xFF249FA9),
                    const Color(0xFFD8F3F3),
                    'Stress Management',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SlideTransition(
              position: _card3SlideAnimation,
              child: FadeTransition(
                opacity: _card3FadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: _buildCompetencyCard(
                    '🤝',
                    'Interpersonal Management',
                    'Connect with others',
                    const Color(0xFF43C76F),
                    const Color(0xFFD4EDDD),
                    'Interpersonal Management',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SlideTransition(
              position: _card4SlideAnimation,
              child: FadeTransition(
                opacity: _card4FadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: _buildCompetencyCard(
                    '⚡',
                    'Spirit Management',
                    'Fuel your daily drive',
                    const Color(0xFFF37C21),
                    const Color(0xFFEFE0D5),
                    'Spirit Management',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SlideTransition(
              position: _card5SlideAnimation,
              child: FadeTransition(
                opacity: _card5FadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: _buildCompetencyCard(
                    '🧭',
                    'Executive Functioning',
                    'Plan and execute',
                    const Color(0xFF96B6F0),
                    const Color(0xFFD4DEEF),
                    'Executive Functioning',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SlideTransition(
              position: _card6SlideAnimation,
              child: FadeTransition(
                opacity: _card6FadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: _buildCompetencyCard(
                    '🎯',
                    'Decision Making',
                    'Navigate complex choices',
                    const Color(0xFF6A95E2),
                    const Color(0xFFD5DFF1),
                    'Decision Making',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Continue Button - Slides from left
            SlideTransition(
              position: _continueButtonSlideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to journey details (Here's your guided journey)
                      context.push('/journey-details');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF073B4B),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Continue with my own journey',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 12),
                        Icon(
                          Icons.arrow_forward,
                          size: 16,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Back Link - Slides from right
            SlideTransition(
              position: _backLinkSlideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        context.go('/result-onboarding');
                      }
                    },
                    child: const Text(
                      'Go back to my recommeded journey',
                      style: TextStyle(
                        color: Color(0xFF637275),
                        fontSize: 16,
                        fontFamily: 'Plus Jakarta Sans',
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                      ),
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

  Widget _buildCompetencyCard(
    String emoji,
    String title,
    String subtitle,
    Color borderColor,
    Color bgColor,
    String competencyKey,
  ) {
    final currentPriority = _priorities[competencyKey];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor, width: 4),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF0B191D),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF0B191D),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) {
                final priority = index + 1;
                final isSelected = currentPriority == priority;

                return GestureDetector(
                  onTap: () => _setPriority(competencyKey, priority),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutBack,
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isSelected ? borderColor : Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ]
                          : null,
                    ),
                    child: Center(
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF0B191D),
                          fontSize: isSelected ? 14 : 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.60,
                        ),
                        child: Text('$priority'),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
