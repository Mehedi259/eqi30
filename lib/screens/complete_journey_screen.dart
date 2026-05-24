import 'package:flutter/material.dart';
import 'journey_completed_screen.dart';

class CompleteJourneyScreen extends StatefulWidget {
  const CompleteJourneyScreen({super.key});

  @override
  State<CompleteJourneyScreen> createState() => _CompleteJourneyScreenState();
}

class _CompleteJourneyScreenState extends State<CompleteJourneyScreen> {
  String? selectedFeeling;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    _buildSuccessIcon(),
                    const SizedBox(height: 24),
                    _buildTitle(),
                    const SizedBox(height: 24),
                    _buildStreakBadge(),
                    const SizedBox(height: 32),
                    _buildQuestion(),
                    const SizedBox(height: 16),
                    _buildFeelingOptions(),
                    const SizedBox(height: 24),
                    _buildMotivationalText(),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
            _buildBottomButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.arrow_back, size: 20),
            ),
          ),
          const Expanded(
            child: Text(
              'Complete Journey',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF0B191D),
                fontSize: 18,
                fontFamily: 'Archivo',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF22C55E),
            ),
          ),
          const Icon(Icons.check, size: 60, color: Colors.white),
          Positioned(
            right: 10,
            top: 15,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF22C55E).withOpacity(0.3),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return const Column(
      children: [
        Text(
          'Practice complete,',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF0B191D),
            fontSize: 28,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          'Sarah!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF0B191D),
            fontSize: 28,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildStreakBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF3C7),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: const Color(0xFFFDE68A), width: 1),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('🔥', style: TextStyle(fontSize: 20)),
          SizedBox(width: 8),
          Text(
            '4-day streak - you\'re on a roll!',
            style: TextStyle(
              color: Color(0xFFD97706),
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestion() {
    return const Text(
      'How did that 5-minute exercise feel?',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color(0xFF637275),
        fontSize: 16,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildFeelingOptions() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildFeelingCard('😌', 'More calm')),
            const SizedBox(width: 12),
            Expanded(child: _buildFeelingCard('🧠', 'More clear')),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildFeelingCard('🎯', 'More focused')),
            const SizedBox(width: 12),
            Expanded(child: _buildFeelingCard('⏳', 'No change yet')),
          ],
        ),
      ],
    );
  }

  Widget _buildFeelingCard(String emoji, String label) {
    final isSelected = selectedFeeling == label;

    return GestureDetector(
      onTap: () => setState(() => selectedFeeling = label),
      child: Container(
        height: 110,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE0F2F1) : const Color(0xFFE5E7EB),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF3D8C8C) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 36)),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF0B191D),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMotivationalText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(
          style: TextStyle(
            color: Color(0xFF637275),
            fontSize: 14,
            fontFamily: 'Inter',
            fontStyle: FontStyle.italic,
            height: 1.5,
          ),
          children: [
            TextSpan(text: 'Small daily practices like this are '),
            TextSpan(
              text: 'how your EQi30 abilities grow',
              style: TextStyle(
                color: Color(0xFF3D8C8C),
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(text: ' — week by week, not all at once.'),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.all(26),
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const JourneyCompletedScreen(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF073B4B),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Let\'s try a 2-minute exercise',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 12),
              Icon(Icons.arrow_forward, color: Colors.white, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
