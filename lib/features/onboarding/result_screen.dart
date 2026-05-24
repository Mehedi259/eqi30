import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingResultScreen extends StatefulWidget {
  const OnboardingResultScreen({super.key});

  @override
  State<OnboardingResultScreen> createState() => _OnboardingResultScreenState();
}

class _OnboardingResultScreenState extends State<OnboardingResultScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _progressController;
  late Animation<double> _headerAnimation;
  late Animation<double> _cardAnimation;
  late Animation<double> _buttonAnimation;

  // Progress animations for each card
  late Animation<double> _progress1Animation;
  late Animation<double> _progress2Animation;
  late Animation<double> _progress3Animation;
  late Animation<double> _progress4Animation;
  late Animation<double> _progress5Animation;
  late Animation<double> _progress6Animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _progressController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    _headerAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );

    _cardAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.7, curve: Curves.easeOut),
      ),
    );

    _buttonAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
      ),
    );

    // Staggered progress bar animations
    _progress1Animation = Tween<double>(begin: 0.0, end: 0.42).animate(
      CurvedAnimation(
        parent: _progressController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOutCubic),
      ),
    );

    _progress2Animation = Tween<double>(begin: 0.0, end: 0.55).animate(
      CurvedAnimation(
        parent: _progressController,
        curve: const Interval(0.1, 0.5, curve: Curves.easeOutCubic),
      ),
    );

    _progress3Animation = Tween<double>(begin: 0.0, end: 0.65).animate(
      CurvedAnimation(
        parent: _progressController,
        curve: const Interval(0.2, 0.6, curve: Curves.easeOutCubic),
      ),
    );

    _progress4Animation = Tween<double>(begin: 0.0, end: 0.78).animate(
      CurvedAnimation(
        parent: _progressController,
        curve: const Interval(0.3, 0.7, curve: Curves.easeOutCubic),
      ),
    );

    _progress5Animation = Tween<double>(begin: 0.0, end: 0.85).animate(
      CurvedAnimation(
        parent: _progressController,
        curve: const Interval(0.4, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    _progress6Animation = Tween<double>(begin: 0.0, end: 0.92).animate(
      CurvedAnimation(
        parent: _progressController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _controller.forward();

    // Start progress animations after cards appear
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        _progressController.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _progressController.dispose();
    super.dispose();
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
          onPressed: () => context.canPop()
              ? context.pop()
              : context.go('/ai-chat-onboarding'),
        ),
        title: const Text(
          'Result',
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
            // Animated Header
            FadeTransition(
              opacity: _headerAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '✦ YOUR EQ SNAPSHOT',
                    style: TextStyle(
                      color: Color(0xFF50A8C0),
                      fontSize: 11,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.10,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Here are you results',
                    style: TextStyle(
                      color: Color(0xFF1A2B4A),
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Selfmanagement Stress management Interpersonal Management Spirit Management Executive functioning and Decision Making.',
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
            ),
            const SizedBox(height: 24),

            // Animated Cards
            FadeTransition(
              opacity: _cardAnimation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.2),
                  end: Offset.zero,
                ).animate(_cardAnimation),
                child: Column(
                  children: [
                    AnimatedBuilder(
                      animation: _progress1Animation,
                      builder: (context, child) {
                        return _buildHighlightedCard(
                          'Self-Management',
                          'Needs Attention',
                          (_progress1Animation.value * 100).toInt(),
                          _progress1Animation.value,
                          const Color(0xFF43BDC7),
                          const Color(0xFFEBFDFF),
                          const Color(0xFF002B2E),
                          showBadge: true,
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    AnimatedBuilder(
                      animation: _progress2Animation,
                      builder: (context, child) {
                        return _buildResultCard(
                          'Stress Management',
                          'Developing',
                          (_progress2Animation.value * 100).toInt(),
                          _progress2Animation.value,
                          const Color(0xFF249FA9),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    AnimatedBuilder(
                      animation: _progress3Animation,
                      builder: (context, child) {
                        return _buildResultCard(
                          'Interpersonal Management',
                          'Good',
                          (_progress3Animation.value * 100).toInt(),
                          _progress3Animation.value,
                          const Color(0xFF43C76F),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    AnimatedBuilder(
                      animation: _progress4Animation,
                      builder: (context, child) {
                        return _buildResultCard(
                          'Spirit Management',
                          'Strong',
                          (_progress4Animation.value * 100).toInt(),
                          _progress4Animation.value,
                          const Color(0xFFF37C21),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    AnimatedBuilder(
                      animation: _progress5Animation,
                      builder: (context, child) {
                        return _buildResultCard(
                          'Executive Function Skill',
                          'Strong',
                          (_progress5Animation.value * 100).toInt(),
                          _progress5Animation.value,
                          const Color(0xFF96B6F0),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    AnimatedBuilder(
                      animation: _progress6Animation,
                      builder: (context, child) {
                        return _buildResultCard(
                          'Decision Making',
                          'Strong',
                          (_progress6Animation.value * 100).toInt(),
                          _progress6Animation.value,
                          const Color(0xFF6A95E2),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Animated Buttons
            FadeTransition(
              opacity: _buttonAnimation,
              child: Column(
                children: [
                  const Text(
                    'Improve your skills in under 5 minutes daily  second line See you recommended journey',
                    style: TextStyle(
                      color: Color(0xFF0B191D),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 1.43,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => context.go('/journey-details'),
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
                            'START YOUR JOURNEY',
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
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => context.go('/custom-journey-onboarding'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(
                          color: Color(0xFF637275),
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Build my own journey',
                            style: TextStyle(
                              color: Color(0xFF637275),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 12),
                          Icon(
                            Icons.arrow_forward,
                            size: 16,
                            color: Color(0xFF637275),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHighlightedCard(
    String title,
    String status,
    int percentage,
    double progressValue,
    Color color,
    Color bgColor,
    Color borderColor, {
    bool showBadge = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 36, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      status,
                      style: TextStyle(
                        color: color,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(9999),
                  child: LinearProgressIndicator(
                    value: progressValue,
                    backgroundColor: const Color(0xFF073B4B),
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    minHeight: 8,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Highest opportunity for growth',
                      style: TextStyle(
                        color: Color(0xFF509BA1),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '$percentage%',
                      style: const TextStyle(
                        color: Color(0xFF073B4B),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (showBadge)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFF002B2E),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: const Text(
                  'Start from here',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildResultCard(
    String title,
    String status,
    int percentage,
    double progressValue,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE4E2E5)),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(9999),
            child: LinearProgressIndicator(
              value: progressValue,
              backgroundColor: const Color(0xFFEFEDF0),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$percentage%',
            style: const TextStyle(
              color: Color(0xFF637275),
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
