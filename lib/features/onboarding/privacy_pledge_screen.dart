import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPledgeScreen extends StatelessWidget {
  const PrivacyPledgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Slightly off-white background if needed
      body: SafeArea(
        child: Column(
          children: [
            // Top Welcome Back text (optional if it's meant to be there)
            Padding(
              padding: const EdgeInsets.only(left: 24.0, top: 24.0, bottom: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Welcome Back !",
                  style: GoogleFonts.inter(
                    color: const Color(0xFF0F3B4A),
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            
            // Main Content Container
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 32),
                      Text(
                        "Your Peace,\nYour Privacy",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF2A3641),
                          fontSize: 28,
                          height: 1.2,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 40),
                      
                      // List Items
                      _buildPrivacyItem(
                        icon: Icons.lock_outline,
                        title: "Everything you share here is confidential",
                        subtitle: "Your thoughts, feelings, and reflections stay private and secure with us.",
                      ),
                      const SizedBox(height: 24),
                      _buildPrivacyItem(
                        icon: Icons.navigation_outlined,
                        title: "This is a self-help tool",
                        subtitle: "EQi30 is designed to support your well-being and personal growth.", // Replaced RiseMind with EQi30
                      ),
                      const SizedBox(height: 24),
                      _buildPrivacyItem(
                        icon: Icons.favorite_border,
                        title: "Not a substitute for professional care",
                        subtitle: "EQi30 is not intended to replace advice, diagnosis, or treatment from a qualified professional.",
                      ),
                      
                      const SizedBox(height: 40),
                      
                      // Acknowledge Box
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAF8F5), // Light mint color
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.verified_outlined,
                              color: Color(0xFF0F3B4A),
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                "By continuing, you acknowledge that you have read and agree to our privacy pledge.",
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF0F3B4A),
                                  fontSize: 14,
                                  height: 1.4,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Link to the next screen, perhaps ai chat onboarding or main app
                            context.go('/ai-chat-onboarding'); 
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0F3B4A),
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "I Agree & Begin My Journey",
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrivacyItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Color(0xFFEBF3F5), // Light blue-gray background for icon
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: const Color(0xFF0F3B4A),
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  color: const Color(0xFF2A3641),
                  fontSize: 16,
                  height: 1.4,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  color: const Color(0xFF717D86),
                  fontSize: 14,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
