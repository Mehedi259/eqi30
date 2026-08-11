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
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back, size: 18),
            ),
          ),
          const Expanded(
            child: Text(
              'Emotional Awareness Journey',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF0B191D),
                fontSize: 18,
                fontFamily: 'Archivo',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 32),
        ],
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return SizedBox(
      width: 120,
      height: 120,
      child: Center(
        child: Image.asset(
          'assets/images/Practice complete top icon.png',
          width: 120,
          height: 120,
          fit: BoxFit.contain,
        ),
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
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        'Small daily practices like this are how your EQi30 abilities grow — week by week, not all at once.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF637275),
          fontSize: 14,
          fontFamily: 'Inter',
          fontStyle: FontStyle.italic,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.all(26),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF073B4B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back, color: Colors.white, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Go Back',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
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
              child: const Text(
                'Save and Exit',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
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
}
