import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  Future<void> _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      context.go('/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.50, 0.00),
            end: Alignment(0.50, 1.00),
            colors: [Color(0xFFFFE7DB), Color(0xFFDAF8FF)],
          ),
        ),
        child: Stack(
          children: [
            // Background decorative shapes
            Positioned(
              right: -50,
              top: size.height * 0.5,
              child: Opacity(
                opacity: 0.20,
                child: Transform.rotate(
                  angle: 0.96,
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
            Positioned(
              left: -100,
              top: -71,
              child: Opacity(
                opacity: 0.20,
                child: Transform.rotate(
                  angle: 0.60,
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

            // Main content
            SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 38),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo
                      Container(
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
                      const SizedBox(height: 40),

                      // Tagline
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
              ),
            ),

            // Bottom indicator (iPhone home indicator style)
            Positioned(
              left: 0,
              right: 0,
              bottom: 24,
              child: Center(
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
          ],
        ),
      ),
    );
  }
}
