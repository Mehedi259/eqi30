import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _backgroundController;

  late Animation<double> _logoFadeAnimation;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _backgroundAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
    _navigateToLogin();
  }

  void _initializeAnimations() {
    // Logo animations
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _logoScaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.8, curve: Curves.elasticOut),
      ),
    );

    // Text animations
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeIn));

    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));

    // Background animation
    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _backgroundAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _backgroundController, curve: Curves.easeInOut),
    );
  }

  void _startAnimations() {
    _backgroundController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _logoController.forward();
    });
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) _textController.forward();
    });
  }

  Future<void> _navigateToLogin() async {
    await Future.delayed(const Duration(milliseconds: 3500));
    if (mounted) {
      context.go('/onboarding');
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _backgroundAnimation,
        builder: (context, child) {
          return Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.50, 0.00),
                end: Alignment(0.50, 1.00),
                colors: [
                  Color.lerp(
                    const Color(0xFFFFFFFF),
                    const Color(0xFFFFE7DB),
                    _backgroundAnimation.value,
                  )!,
                  Color.lerp(
                    const Color(0xFFFFFFFF),
                    const Color(0xFFDAF8FF),
                    _backgroundAnimation.value,
                  )!,
                ],
              ),
            ),
            child: child,
          );
        },
        child: Stack(
          children: [
            // Animated background decorative shapes
            AnimatedBuilder(
              animation: _backgroundAnimation,
              builder: (context, child) {
                return Stack(
                  children: [
                    Positioned(
                      right: -50,
                      top: size.height * 0.5,
                      child: Opacity(
                        opacity: 0.20 * _backgroundAnimation.value,
                        child: Transform.rotate(
                          angle: 0.96,
                          child: Transform.scale(
                            scale: _backgroundAnimation.value,
                            child: Container(
                              width: 201,
                              height: 574,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1C182),
                                borderRadius: BorderRadius.circular(150),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: -100,
                      top: -71,
                      child: Opacity(
                        opacity: 0.20 * _backgroundAnimation.value,
                        child: Transform.rotate(
                          angle: 0.60,
                          child: Transform.scale(
                            scale: _backgroundAnimation.value,
                            child: Container(
                              width: size.width * 1.4,
                              height: 260,
                              decoration: BoxDecoration(
                                color: const Color(0xFF3D8C8C),
                                borderRadius: BorderRadius.circular(130),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            // Main content
            SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 38),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Animated Logo
                      AnimatedBuilder(
                        animation: _logoController,
                        builder: (context, child) {
                          return FadeTransition(
                            opacity: _logoFadeAnimation,
                            child: ScaleTransition(
                              scale: _logoScaleAnimation,
                              child: Container(
                                width: size.width * 0.5,
                                height: size.width * 0.5,
                                constraints: const BoxConstraints(
                                  maxWidth: 200,
                                  maxHeight: 200,
                                ),
                                child: Image.asset(
                                  'assets/images/splashScreenLogo.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 40),

                      // Animated Tagline
                      AnimatedBuilder(
                        animation: _textController,
                        builder: (context, child) {
                          return FadeTransition(
                            opacity: _textFadeAnimation,
                            child: SlideTransition(
                              position: _textSlideAnimation,
                              child: Column(
                                children: [
                                  Text(
                                    '30 Micro-Abilities for Calmer,',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFF637275),
                                      fontSize: size.width * 0.05 > 20
                                          ? 20
                                          : size.width * 0.05,
                                      fontWeight: FontWeight.w400,
                                      height: 1.50,
                                    ),
                                  ),
                                  Text(
                                    'Clearer, More Effective Leadership',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFF637275),
                                      fontSize: size.width * 0.05 > 20
                                          ? 20
                                          : size.width * 0.05,
                                      fontWeight: FontWeight.w400,
                                      height: 1.50,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Animated bottom indicator
            AnimatedBuilder(
              animation: _textController,
              builder: (context, child) {
                return Positioned(
                  left: 0,
                  right: 0,
                  bottom: 24,
                  child: Center(
                    child: FadeTransition(
                      opacity: _textFadeAnimation,
                      child: Container(
                        width: 144,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
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
