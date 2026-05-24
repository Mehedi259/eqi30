import 'package:flutter/material.dart';
import 'complete_journey_screen.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  String? selectedFeeling;
  final TextEditingController reflectionController = TextEditingController();
  final TextEditingController practiceController = TextEditingController();

  @override
  void dispose() {
    reflectionController.dispose();
    practiceController.dispose();
    super.dispose();
  }

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    _buildProgressSection(),
                    const SizedBox(height: 24),
                    _buildTitle(),
                    const SizedBox(height: 12),
                    _buildRealLifePlan(),
                    const SizedBox(height: 16),
                    _buildQuickReflection(),
                    const SizedBox(height: 16),
                    _buildTodaysTeaching(),
                    const SizedBox(height: 16),
                    _buildInAppPractice(),
                    const SizedBox(height: 24),
                    _buildCompletionIndicators(),
                    const SizedBox(height: 16),
                    _buildCompletedButton(),
                    const SizedBox(height: 24),
                    _buildActionButtons(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
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
              'Learning',
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

  Widget _buildProgressSection() {
    return Column(
      children: [
        Container(
          height: 3,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.12),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: 0.033,
              child: Container(
                height: 3,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3D8C8C), Color(0xFFE8A54B)],
                  ),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Emotional Awareness',
                  style: TextStyle(
                    color: Color(0xFF637275),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  'Day 1 of 30',
                  style: TextStyle(
                    color: Color(0xFF0B191D),
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 1.50,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
              decoration: BoxDecoration(
                color: const Color(0x33E8A54B),
                border: Border.all(color: const Color(0x66E8A54B)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                '🔥 3-day streak',
                style: TextStyle(
                  color: Color(0xFFE8A54B),
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 1.50,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return const Text(
      'From \'Fine\' to a Feeling',
      style: TextStyle(
        color: Color(0xFF1A2B4A),
        fontSize: 24,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        height: 1.33,
      ),
    );
  }

  Widget _buildRealLifePlan() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE0EEEE)),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text(
                '🎯',
                style: TextStyle(
                  fontSize: 20,
                  height: 1.20,
                  letterSpacing: 0.80,
                ),
              ),
              SizedBox(width: 8),
              Text(
                'Today\'s Real-Life Plan',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 1.44,
                  letterSpacing: 0.80,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFA),
              border: Border.all(color: const Color(0xFFE0EEEE)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDBEAFE),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'IF',
                    style: TextStyle(
                      color: Color(0xFF1E40AF),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      height: 1.43,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Someone asks "How are you?"',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Inter',
                      height: 1.43,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFA),
              border: Border.all(color: const Color(0xFFE0EEEE)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCFCE7),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'THEN',
                    style: TextStyle(
                      color: Color(0xFF166534),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      height: 1.43,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'I will pause for 2 seconds and use a specific emotion word.',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Inter',
                      height: 1.43,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickReflection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5FCFF),
        border: Border.all(color: const Color(0xFFE2F9FF)),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text('💭', style: TextStyle(fontSize: 20, height: 1.20)),
              SizedBox(width: 8),
              Text(
                'Quick Reflection',
                style: TextStyle(
                  color: Color(0xFF095A70),
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 1.44,
                  letterSpacing: 0.80,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Why do you think it\'s so easy to default to "fine"?',
            style: TextStyle(fontSize: 14, fontFamily: 'Inter', height: 1.71),
          ),
          const SizedBox(height: 12),
          Container(
            height: 135,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFE3F9FF)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: reflectionController,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'Tap to type your reflection...',
                hintStyle: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  height: 1.43,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodaysTeaching() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFF3D8C8C), width: 4),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text(
                '📖',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.50,
                  letterSpacing: 0.80,
                ),
              ),
              SizedBox(width: 8),
              Text(
                'Today\'s Teaching',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 1.44,
                  letterSpacing: 0.80,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'When we say we feel "fine", we\'re often masking a complex web of emotions. True emotional awareness starts with finding the specific word for what you\'re experiencing.',
            style: TextStyle(fontSize: 16, fontFamily: 'Inter', height: 1.50),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('💡', style: TextStyle(fontSize: 20, height: 1.40)),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Key Concept: Granularity. The ability to\ndistinguish between nuanced feelings (e.g., "annoyed" vs "angry") reduces the\nemotional intensity by up to 50%.',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Inter',
                      height: 1.71,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInAppPractice() {
    final feelings = [
      ['Calm', 'Annoyed', 'Hopeful', 'Anxious'],
      ['Tired', 'Overwhelmed', 'Curious'],
    ];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE8A54B), width: 4),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text(
                '✏️',
                style: TextStyle(
                  fontSize: 20,
                  height: 1.20,
                  letterSpacing: 0.80,
                ),
              ),
              SizedBox(width: 8),
              Text(
                'In-App Practice',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 1.44,
                  letterSpacing: 0.80,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Once today, when you notice you\'re thinking "I\'m fine" - pause.',
              style: TextStyle(fontSize: 16, fontFamily: 'Inter', height: 1.50),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Select what you\'re actually feeling:',
            style: TextStyle(fontSize: 16, fontFamily: 'Inter', height: 1.50),
          ),
          const SizedBox(height: 12),
          ...feelings.map(
            (row) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Wrap(
                spacing: 8,
                children: row
                    .map((feeling) => _buildFeelingChip(feeling))
                    .toList(),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 96,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFA),
              border: Border.all(color: const Color(0xFFE0EEEE)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: practiceController,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'Right now, I feel...',
                hintStyle: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  height: 1.43,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeelingChip(String feeling) {
    final isSelected = selectedFeeling == feeling;
    return GestureDetector(
      onTap: () => setState(() => selectedFeeling = feeling),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : const Color(0xFFF8FAFA),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF2A8B8B)
                : const Color(0xFFE0EEEE),
          ),
          borderRadius: BorderRadius.circular(9999),
        ),
        child: Text(
          feeling,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: 'Inter',
            height: 1.50,
          ),
        ),
      ),
    );
  }

  Widget _buildCompletionIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildIndicator('📖', 'Teaching'),
        const SizedBox(width: 16),
        _buildIndicator('✏️', 'Practice'),
        const SizedBox(width: 16),
        _buildIndicator('💭', 'Reflection'),
      ],
    );
  }

  Widget _buildIndicator(String emoji, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'Inter',
            height: 1.43,
          ),
        ),
      ],
    );
  }

  Widget _buildCompletedButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CompleteJourneyScreen(),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: const Color(0xFF4B8FE8),
          border: Border.all(color: const Color(0x140F1E3C)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0x0F0F1E3C)),
          ),
          child: const Text(
            'COMPLETED IN APP PRACTICE',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Inter',
              height: 1.57,
            ),
          ),
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
              // Continue action
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
              children: const [
                Text(
                  'continue',
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
          onTap: () {
            // Skip action
          },
          child: const Text(
            'Skip for Today',
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
    );
  }
}
