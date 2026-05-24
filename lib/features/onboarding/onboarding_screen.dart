import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _imageAnimation;
  late Animation<double> _textAnimation;
  late Animation<Offset> _buttonSlideAnimation;
  late Animation<double> _buttonFadeAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _controller.forward();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Image fade and scale animation
    _imageAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    // Text fade animation
    _textAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.7, curve: Curves.easeIn),
      ),
    );

    // Button slide animation
    _buttonSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
          ),
        );

    // Button fade animation
    _buttonFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    // Animated Human image with lungs
                    AnimatedBuilder(
                      animation: _imageAnimation,
                      builder: (context, child) {
                        return FadeTransition(
                          opacity: _imageAnimation,
                          child: Transform.scale(
                            scale: 0.8 + (_imageAnimation.value * 0.2),
                            child: Container(
                              width: 300,
                              height: 450,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 26,
                              ),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/Human.png'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    // Animated Title text
                    AnimatedBuilder(
                      animation: _textAnimation,
                      builder: (context, child) {
                        return FadeTransition(
                          opacity: _textAnimation,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 60),
                            child: Text(
                              'The stuff that nobody taught you.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF0B191D),
                                fontSize: 24,
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.w700,
                                height: 1.25,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            // Animated Bottom buttons
            AnimatedBuilder(
              animation: _buttonFadeAnimation,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _buttonFadeAnimation,
                  child: SlideTransition(
                    position: _buttonSlideAnimation,
                    child: Padding(
                      padding: const EdgeInsets.all(26),
                      child: Column(
                        children: [
                          // Next button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                // Navigate to AI chat onboarding
                                context.go('/ai-chat-onboarding');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF073B4B),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Let's try a 2-minute exercise",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      height: 1.50,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Skip button
                          TextButton(
                            onPressed: () {
                              // Skip onboarding and go to login
                              context.go('/login');
                            },
                            child: Text(
                              'I already know what I want to work on.',
                              style: TextStyle(
                                color: const Color(0xFF0B191D),
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
