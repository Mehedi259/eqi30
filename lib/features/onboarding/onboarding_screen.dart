import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Human image with lungs
                  Container(
                    width: 351,
                    height: 554,
                    margin: const EdgeInsets.symmetric(horizontal: 26),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/Human.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Title text
                  Padding(
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
                ],
              ),
            ),
            // Bottom buttons
            Padding(
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
          ],
        ),
      ),
    );
  }
}
