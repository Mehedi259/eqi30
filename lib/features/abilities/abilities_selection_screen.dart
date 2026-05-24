import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AbilitiesSelectionScreen extends StatefulWidget {
  const AbilitiesSelectionScreen({super.key});

  @override
  State<AbilitiesSelectionScreen> createState() =>
      _AbilitiesSelectionScreenState();
}

class _AbilitiesSelectionScreenState extends State<AbilitiesSelectionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _headerSlideAnimation;
  late Animation<Offset> _row1LeftSlideAnimation;
  late Animation<Offset> _row1RightSlideAnimation;
  late Animation<Offset> _row2LeftSlideAnimation;
  late Animation<Offset> _row2RightSlideAnimation;
  late Animation<Offset> _row3LeftSlideAnimation;
  late Animation<Offset> _row3RightSlideAnimation;
  late Animation<Offset> _continueButtonSlideAnimation;
  late Animation<Offset> _backButtonSlideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Very subtle upward slide with smooth fade
    _headerSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.02),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _row1LeftSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.02),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _row1RightSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.02),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _row2LeftSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.02),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _row2RightSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.02),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _row3LeftSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.02),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _row3RightSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.02),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _continueButtonSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.02),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _backButtonSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.02),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

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
            child: const Icon(Icons.arrow_back, size: 16),
          ),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'EQ Journey',
          style: TextStyle(
            color: Color(0xFF0B191D),
            fontSize: 18,
            fontFamily: 'Archivo',
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
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
                              '✦ YOUR EQ JOURNEY',
                              style: TextStyle(
                                color: Color(0xFF50A8C0),
                                fontSize: 11,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.10,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Choose your growth area.',
                              style: TextStyle(
                                color: Color(0xFF0B191D),
                                fontSize: 24,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                height: 1.33,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Row 1
                    Row(
                      children: [
                        Expanded(
                          child: SlideTransition(
                            position: _row1LeftSlideAnimation,
                            child: FadeTransition(
                              opacity: _fadeAnimation,
                              child: _buildAbilityCard(
                                context,
                                emoji: '🧠',
                                title: 'Self Management',
                                subtitle: 'Emotions · Confidence · Boundaries',
                                color: const Color(0xFF43BDC7),
                                lightColor: const Color(0xFF72D8E0),
                                progress: 0.7,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: SlideTransition(
                            position: _row1RightSlideAnimation,
                            child: FadeTransition(
                              opacity: _fadeAnimation,
                              child: _buildAbilityCard(
                                context,
                                emoji: '🤝',
                                title: 'Interpersonal',
                                subtitle: 'Empathy · Communication · Conflict',
                                color: const Color(0xFF43C76F),
                                lightColor: const Color(0xFF87E6A6),
                                progress: 0.8,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Row 2
                    Row(
                      children: [
                        Expanded(
                          child: SlideTransition(
                            position: _row2LeftSlideAnimation,
                            child: FadeTransition(
                              opacity: _fadeAnimation,
                              child: _buildAbilityCard(
                                context,
                                emoji: '🌊',
                                title: 'Stress Management',
                                subtitle: 'Resilience · Flexibility · Optimism',
                                color: const Color(0xFF249FA9),
                                lightColor: const Color(0xFF5BBEC6),
                                progress: 0.6,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: SlideTransition(
                            position: _row2RightSlideAnimation,
                            child: FadeTransition(
                              opacity: _fadeAnimation,
                              child: _buildAbilityCard(
                                context,
                                emoji: '⚡',
                                title: 'Spirit & Energy',
                                subtitle: 'Resilience · Flexibility · Optimism',
                                color: const Color(0xFFF37C21),
                                lightColor: const Color(0xFFFF9C50),
                                progress: 0.9,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Row 3
                    Row(
                      children: [
                        Expanded(
                          child: SlideTransition(
                            position: _row3LeftSlideAnimation,
                            child: FadeTransition(
                              opacity: _fadeAnimation,
                              child: _buildAbilityCard(
                                context,
                                emoji: '🧭',
                                title: 'Executive Function',
                                subtitle: 'Planning · Flexibility · Optimism',
                                color: const Color(0xFF96B6F0),
                                lightColor: const Color(0xFFB4CDFB),
                                progress: 0.5,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: SlideTransition(
                            position: _row3RightSlideAnimation,
                            child: FadeTransition(
                              opacity: _fadeAnimation,
                              child: _buildAbilityCard(
                                context,
                                emoji: '🎯',
                                title: 'Decision making',
                                subtitle: 'Intuition · Logic · Wisdom',
                                color: const Color(0xFF6A95E2),
                                lightColor: const Color(0xFF90B2EF),
                                progress: 0.7,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(26),
              child: Column(
                children: [
                  // Continue button - Slides from left
                  SlideTransition(
                    position: _continueButtonSlideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            context.push('/journey');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF073B4B),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Continue to Journey',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 12),
                              Icon(Icons.arrow_forward, size: 16),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Back button - Slides from right
                  SlideTransition(
                    position: _backButtonSlideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            context.pop();
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 15,
                            ),
                            side: const BorderSide(color: Colors.transparent),
                            backgroundColor: const Color(
                              0xFFDCF7FB,
                            ).withOpacity(0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Go Back',
                            style: TextStyle(
                              color: Color(0xFF0B191D),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
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

  Widget _buildAbilityCard(
    BuildContext context, {
    required String emoji,
    required String title,
    required String subtitle,
    required Color color,
    required Color lightColor,
    required double progress,
  }) {
    // Convert title to competency ID
    String competencyId = title.toLowerCase().replaceAll(' ', '-');
    String colorHex =
        '#${color.value.toRadixString(16).substring(2).toUpperCase()}';

    return GestureDetector(
      onTap: () {
        context.push(
          '/abilities-under-competency?competencyId=$competencyId&name=$title&color=$colorHex',
        );
      },
      child: Container(
        height: 196,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: lightColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 32)),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF0B191D),
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                height: 1.38,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: TextStyle(
                color: const Color(0xFF0B191D).withOpacity(0.6),
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  flex: (progress * 10).toInt(),
                  child: Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: lightColor,
                      borderRadius: BorderRadius.circular(91),
                    ),
                  ),
                ),
                if (progress < 1)
                  Expanded(
                    flex: ((1 - progress) * 10).toInt(),
                    child: Container(
                      height: 6,
                      margin: const EdgeInsets.only(left: 2),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(91),
                      ),
                    ),
                  ),
                const SizedBox(width: 4),
                Container(
                  width: 24,
                  height: 24,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: lightColor.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(92),
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    size: 14,
                    color: Color(0xFF0B191D),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
