import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingResultScreen extends StatelessWidget {
  const OnboardingResultScreen({super.key});

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
              color: Colors.black.withOpacity(0.10),
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(Icons.arrow_back, size: 16, color: Colors.black),
          ),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/ai-chat-onboarding');
            }
          },
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
            // Header
            const Text(
              '✦ YOUR EQ SNAPSHOT',
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
              'Here are you results',
              style: TextStyle(
                color: Color(0xFF1A2B4A),
                fontSize: 24,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Selfmanagement Stress management Interpersonal Management Spirit Management Executive functioning and Decision Making.',
              style: TextStyle(
                color: Color(0xFF8A96A8),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1.43,
              ),
            ),
            const SizedBox(height: 24),
            
            // Results Cards
            _buildHighlightedCard(
              'Self-Management',
              'Needs Attention',
              42,
              const Color(0xFF43BDC7),
              const Color(0xFFEBFDFF),
              const Color(0xFF002B2E),
              showBadge: true,
            ),
            const SizedBox(height: 12),
            _buildResultCard(
              'Stress Management',
              'Developing',
              55,
              const Color(0xFF249FA9),
            ),
            const SizedBox(height: 12),
            _buildResultCard(
              'Interpersonal Management',
              'Good',
              65,
              const Color(0xFF43C76F),
            ),
            const SizedBox(height: 12),
            _buildResultCard(
              'Spirit Management',
              'Strong',
              78,
              const Color(0xFFF37C21),
            ),
            const SizedBox(height: 12),
            _buildResultCard(
              'Executive Function Skill',
              'Strong',
              85,
              const Color(0xFF96B6F0),
            ),
            const SizedBox(height: 12),
            _buildResultCard(
              'Decision Making',
              'Strong',
              92,
              const Color(0xFF6A95E2),
            ),
            const SizedBox(height: 24),
            
            // Bottom Text
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
            
            // Buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to journey details
                  context.go('/journey-details');
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
                      'START YOUR JOURNEY',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 12),
                    Icon(Icons.arrow_forward, size: 16, color: Colors.white),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // Navigate to custom journey
                  context.go('/custom-journey-onboarding');
                },
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
                    Icon(Icons.arrow_forward, size: 16, color: Color(0xFF637275)),
                  ],
                ),
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
            color: Colors.black.withOpacity(0.08),
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
                    value: percentage / 100,
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
          // Badge at top corner
          if (showBadge)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
            color: Colors.black.withOpacity(0.02),
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
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
              value: percentage / 100,
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
