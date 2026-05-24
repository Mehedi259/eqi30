import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';
import 'package:go_router/go_router.dart';

class JourneyCompletedScreen extends StatefulWidget {
  const JourneyCompletedScreen({super.key});

  @override
  State<JourneyCompletedScreen> createState() => _JourneyCompletedScreenState();
}

class _JourneyCompletedScreenState extends State<JourneyCompletedScreen> {
  late ConfettiController _confettiControllerCenter;
  late ConfettiController _confettiControllerLeft;
  late ConfettiController _confettiControllerRight;

  @override
  void initState() {
    super.initState();
    _confettiControllerCenter = ConfettiController(
      duration: const Duration(seconds: 4),
    );
    _confettiControllerLeft = ConfettiController(
      duration: const Duration(seconds: 4),
    );
    _confettiControllerRight = ConfettiController(
      duration: const Duration(seconds: 4),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      _confettiControllerCenter.play();
      _confettiControllerLeft.play();
      _confettiControllerRight.play();
    });
  }

  @override
  void dispose() {
    _confettiControllerCenter.dispose();
    _confettiControllerLeft.dispose();
    _confettiControllerRight.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                _buildAppBar(context),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildHeaderSection(),
                        const SizedBox(height: 24),
                        _buildContentSection(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Center Confetti
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiControllerCenter,
              blastDirection: pi / 2,
              emissionFrequency: 0.03,
              numberOfParticles: 30,
              gravity: 0.2,
              shouldLoop: false,
              blastDirectionality: BlastDirectionality.explosive,
              colors: const [
                Color(0xFF006767),
                Color(0xFFFFB95D),
                Color(0xFFA9633D),
                Color(0xFFBA1A1A),
                Color(0xFF855400),
                Color(0xFF8B4B27),
              ],
            ),
          ),
          // Left Confetti
          Align(
            alignment: Alignment.topLeft,
            child: ConfettiWidget(
              confettiController: _confettiControllerLeft,
              blastDirection: 0,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.2,
              shouldLoop: false,
              maxBlastForce: 20,
              minBlastForce: 10,
              colors: const [
                Color(0xFF006767),
                Color(0xFFFFB95D),
                Color(0xFFA9633D),
                Color(0xFFBA1A1A),
                Color(0xFF855400),
                Color(0xFF8B4B27),
              ],
            ),
          ),
          // Right Confetti
          Align(
            alignment: Alignment.topRight,
            child: ConfettiWidget(
              confettiController: _confettiControllerRight,
              blastDirection: pi,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.2,
              shouldLoop: false,
              maxBlastForce: 20,
              minBlastForce: 10,
              colors: const [
                Color(0xFF006767),
                Color(0xFFFFB95D),
                Color(0xFFA9633D),
                Color(0xFFBA1A1A),
                Color(0xFF855400),
                Color(0xFF8B4B27),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.10),
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(Icons.arrow_back, size: 16),
            ),
          ),
          const Expanded(
            child: Text(
              'Journey Completed',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF0B191D),
                fontSize: 18,
                fontFamily: 'Archivo',
                fontWeight: FontWeight.w600,
                height: 1.11,
              ),
            ),
          ),
          const SizedBox(width: 24),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      width: double.infinity,
      height: 280,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.50, 0.00),
          end: Alignment(0.50, 1.00),
          colors: [Color(0xFFD8F3F3), Colors.white],
        ),
      ),
      child: Stack(
        children: [
          // Decorative shapes
          _buildDecorativeShape(
            113.14,
            102,
            8,
            16,
            const Color(0xFF006767),
            0.26,
          ),
          _buildDecorativeShape(
            312,
            167.38,
            8,
            16,
            const Color(0xFF855400),
            -0.44,
          ),
          _buildDecorativeShape(
            241.66,
            94,
            16,
            8,
            const Color(0xFF8B4B27),
            0.79,
          ),
          _buildDecorativeShape(
            67,
            169.07,
            8,
            16,
            const Color(0xFFBA1A1A),
            -0.26,
          ),
          _buildDecorativeSquare(58.50, 120, 8, const Color(0xFF006767)),
          _buildDecorativeSquare(197, 116, 8, const Color(0xFFFFB95D)),
          _buildDecorativeSquare(312, 135, 8, const Color(0xFFA9633D)),
          // Trophy icon
          Positioned(left: 133, top: 53, child: _buildTrophyIcon()),
        ],
      ),
    );
  }

  Widget _buildDecorativeShape(
    double left,
    double top,
    double width,
    double height,
    Color color,
    double rotation,
  ) {
    return Positioned(
      left: left,
      top: top,
      child: Transform.rotate(
        angle: rotation,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _buildDecorativeSquare(
    double left,
    double top,
    double size,
    Color color,
  ) {
    return Positioned(
      left: left,
      top: top,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  Widget _buildTrophyIcon() {
    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0x0C006767),
              border: Border.all(color: const Color(0x26006767), width: 2),
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: const Color(0xFF006767),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0x0F1A3333),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Center(
              child: Text('🏆', style: TextStyle(fontSize: 40)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: Column(
        children: [
          _buildCompletionBadge(),
          const SizedBox(height: 8),
          _buildTitle(),
          const SizedBox(height: 8),
          _buildDescription(),
          const SizedBox(height: 32),
          _buildStatsCards(),
          const SizedBox(height: 24),
          _buildAICoachSuggestion(),
          const SizedBox(height: 24),
          _buildActionButtons(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildCompletionBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFD8F3F3),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: const Text(
        '60-Day Journey Complete ✓',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF006767),
          fontSize: 12,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          height: 1.33,
          letterSpacing: 0.60,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      'You did it, Sarah! 🎉',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color(0xFF051F1F),
        fontSize: 28,
        fontFamily: 'Plus Jakarta Sans',
        fontWeight: FontWeight.w600,
        height: 1.29,
      ),
    );
  }

  Widget _buildDescription() {
    return const SizedBox(
      width: 350,
      child: Text(
        'You\'ve completed your full 60-day\nEmotional Awareness journey. This is a\ngenuine achievement.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF3E4948),
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          height: 1.50,
        ),
      ),
    );
  }

  Widget _buildStatsCards() {
    return Row(
      children: [
        Expanded(child: _buildStatCard('60', 'Days', const Color(0xFF006767))),
        const SizedBox(width: 8),
        Expanded(
          child: _buildStatCard('60', 'Practices', const Color(0xFF855400)),
        ),
        const SizedBox(width: 8),
        Expanded(child: _buildStatCard('3', 'Badges', const Color(0xFF8B4B27))),
      ],
    );
  }

  Widget _buildStatCard(String value, String label, Color valueColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFCCE8E7)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 26,
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.w700,
              height: 1.23,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF3E4948),
              fontSize: 12,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 1.33,
              letterSpacing: 0.60,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAICoachSuggestion() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0x19FFB95D),
        border: Border.all(color: const Color(0x3FFFB95D)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x0C000000),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text('🤖', style: TextStyle(fontSize: 20)),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Your AI Coach has a suggestion...',
                style: TextStyle(
                  color: Color(0xFF855400),
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 1.33,
                  letterSpacing: 0.60,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x0C000000),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: const Text(
              'Research shows that an additional 10 days of practice can deepen these skills significantly. You\'ve built great momentum - would you like to extend your journey with 10 bonus practices?',
              style: TextStyle(
                color: Color(0xFF3E4948),
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildInfoChip('📅 10 more days'),
              const SizedBox(width: 8),
              _buildInfoChip('⏱ 5 min/day'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFCCE8E7)),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF3E4948),
          fontSize: 12,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          height: 1.33,
          letterSpacing: 0.60,
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              context.push('/progress-tracker');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF073B4B),
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Yes Keep Growing! 10 More Days',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(Icons.arrow_forward, color: Colors.white, size: 16),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              side: const BorderSide(color: Color(0xFF006767)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'No thanks - I\'m done for now',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF006767),
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                height: 1.50,
                letterSpacing: 0.60,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
