import 'package:flutter/material.dart';

class StartJourneyScreen extends StatelessWidget {
  const StartJourneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    _buildCategoryRow(),
                    const SizedBox(height: 16),
                    _buildInfoCards(),
                    const SizedBox(height: 16),
                    _buildJourneyDetails(),
                    const SizedBox(height: 24),
                    _buildWhatYouLearnSection(),
                    const SizedBox(height: 24),
                    _buildJourneyPhasesSection(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            _buildBottomActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
              'Start Journey',
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

  Widget _buildCategoryRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0x1443BDC7),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Self Management',
            style: TextStyle(
              color: Color(0xFF43BDC7),
              fontSize: 12,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              height: 1.50,
            ),
          ),
        ),
        const Text(
          'Recommended First',
          style: TextStyle(
            color: Color(0xFF637275),
            fontSize: 11,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            height: 1.50,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCards() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildInfoCard(
          title: 'WHAT IT IS',
          titleColor: const Color(0xFF006767),
          description: 'Recognizing & naming what you feel in the moment.',
          width: double.infinity,
        ),
        _buildInfoCard(
          title: 'WHY IT MATTERS',
          titleColor: const Color(0xFFE8A54B),
          description:
              'Improves self-control, reduces reactivity, clarifies decisions.',
          width: 171,
        ),
        _buildInfoCard(
          title: 'WHAT YOU\'LL DO',
          titleColor: const Color(0xFF006767),
          description:
              'Short daily check- ins using simple prompts & a feelings list.',
          width: 171,
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required String title,
    required Color titleColor,
    required String description,
    required double width,
  }) {
    return Container(
      width: width == double.infinity ? null : width,
      constraints: width == double.infinity
          ? const BoxConstraints(minWidth: double.infinity)
          : null,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFA),
        border: Border.all(color: const Color(0xFFE0EEEE)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontSize: 12,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 1.33,
              letterSpacing: 0.60,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              color: Color(0xFF3E4948),
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 1.43,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJourneyDetails() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildDetailChip('30-day journey'),
        _buildDetailChip('~5 min/day'),
        _buildDetailChip('60 micro-skills total'),
      ],
    );
  }

  Widget _buildDetailChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFDDF9F8),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF3E4948),
          fontSize: 14,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          height: 1.43,
        ),
      ),
    );
  }

  Widget _buildWhatYouLearnSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What you\'ll Learn',
          style: TextStyle(
            color: Color(0xFF0B191D),
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            height: 1.44,
            letterSpacing: 0.60,
          ),
        ),
        const SizedBox(height: 12),
        _buildLearningItem('Name specific emotions instead of just \'fine\''),
        const SizedBox(height: 8),
        _buildLearningItem('Notice emotions in your body'),
        const SizedBox(height: 8),
        _buildLearningItem('Understand feelings vs thoughts'),
        const SizedBox(height: 8),
        _buildLearningItem('Pause and respond vs react'),
      ],
    );
  }

  Widget _buildLearningItem(String text) {
    return Row(
      children: [
        const Icon(Icons.check_circle, color: Color(0xFF43BDC7), size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF051F1F),
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 1.43,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildJourneyPhasesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Journey Phases',
          style: TextStyle(
            color: Color(0xFF0B191D),
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            height: 1.44,
            letterSpacing: 0.60,
          ),
        ),
        const SizedBox(height: 12),
        _buildPhaseCard(
          emoji: '🧠',
          title: 'Emotional Awareness',
          description: 'Notice and name your emotions in real time.',
          status: 'Day 1/30',
          isActive: true,
        ),
        const SizedBox(height: 12),
        _buildPhaseCard(
          emoji: '🚧',
          title: 'Boundary Awareness',
          description: 'Know your limits and say no without guilt.',
          status: 'Not started',
          isActive: false,
        ),
        const SizedBox(height: 12),
        _buildPhaseCard(
          emoji: '💪',
          title: 'Self-Confidence',
          description: 'Trust your abilities under pressure.',
          status: 'Not started',
          isActive: false,
        ),
        const SizedBox(height: 12),
        _buildPhaseCard(
          emoji: '🌱',
          title: 'Self-Actualization',
          description: 'Move toward your best, not just survive.',
          status: 'Not started',
          isActive: false,
        ),
        const SizedBox(height: 12),
        _buildPhaseCard(
          emoji: '🦅',
          title: 'Independence',
          description: 'Decide for yourself without over-relying on approval.',
          status: 'Not started',
          isActive: false,
        ),
      ],
    );
  }

  Widget _buildPhaseCard({
    required String emoji,
    required String title,
    required String description,
    required String status,
    required bool isActive,
  }) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 3),
          padding: const EdgeInsets.only(
            left: 9,
            top: 12,
            right: 12,
            bottom: 12,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFE0EEEE), width: 1),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 4,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: const Color(0x2643BDC7),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(emoji, style: const TextStyle(fontSize: 32)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF1A2B4A),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 1.43,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Color(0xFF8A96A8),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFFDFF8FF)
                      : const Color(0xFFF1F2F4),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: isActive
                        ? const Color(0xFF50A8C0)
                        : const Color(0xFF8A96A8),
                    fontSize: 10,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.60,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          child: Container(
            width: 3,
            decoration: const BoxDecoration(
              color: Color(0xFF43BDC7),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(26),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to first skill screen
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
                    'Start with first skill',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 1.50,
                    ),
                  ),
                  SizedBox(width: 12),
                  Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Text(
              'Back to home',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF637275),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
                height: 1.43,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
