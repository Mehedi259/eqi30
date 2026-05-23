import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GrowthPaceScreen extends StatefulWidget {
  const GrowthPaceScreen({super.key});

  @override
  State<GrowthPaceScreen> createState() => _GrowthPaceScreenState();
}

class _GrowthPaceScreenState extends State<GrowthPaceScreen> {
  String selectedPace = 'medium';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFEFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBFEFF),
        elevation: 0,
        leading: IconButton(
          icon: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.10),
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(Icons.arrow_back, size: 16),
          ),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Details',
          style: TextStyle(
            color: Color(0xFF0B191D),
            fontSize: 18,
            fontFamily: 'Archivo',
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'How fast do you want to grow?',
                      style: TextStyle(
                        color: Color(0xFF1A2B4A),
                        fontSize: 24,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        height: 1.33,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'You can change this anytime from your settings.',
                      style: TextStyle(
                        color: Color(0xFF8A96A8),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildPaceOption(
                      pace: 'low',
                      emoji: '🌱',
                      label: 'LOW',
                      title: '1 ability per day',
                      subtitle: '≈ 5 minutes daily',
                      color: const Color(0xFF4CAF7D),
                      dots: 1,
                    ),
                    const SizedBox(height: 12),
                    _buildPaceOption(
                      pace: 'medium',
                      emoji: '🔥',
                      label: 'MEDIUM',
                      title: '2 abilities per day',
                      subtitle: '≈ 10 minutes daily',
                      color: const Color(0xFF50A8C0),
                      dots: 2,
                      isGradient: true,
                    ),
                    const SizedBox(height: 12),
                    _buildPaceOption(
                      pace: 'high',
                      emoji: '🚀',
                      label: 'HIGH',
                      title: '3 abilities per day',
                      subtitle: '≈ 15 minutes daily',
                      color: const Color(0xFFE07B6A),
                      dots: 3,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(26),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.push('/time-preference');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF073B4B),
                    padding: const EdgeInsets.all(12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'NEXT',
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaceOption({
    required String pace,
    required String emoji,
    required String label,
    required String title,
    required String subtitle,
    required Color color,
    required int dots,
    bool isGradient = false,
  }) {
    final isSelected = selectedPace == pace;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPace = pace;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: isGradient && isSelected
              ? const LinearGradient(colors: [Colors.white, Color(0xFFDCF1FB)])
              : null,
          color: !isGradient ? Colors.white : null,
          border: Border.all(
            width: isSelected ? 1 : 1,
            color: isSelected
                ? color.withOpacity(0.3)
                : Colors.black.withOpacity(0.20),
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [
                  const BoxShadow(
                    color: Color(0x0A000000),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 24)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: color,
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.88,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF1A2B4A),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF8A96A8),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: List.generate(
                3,
                (index) => Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.only(left: 4),
                  decoration: BoxDecoration(
                    color: index < dots ? color : const Color(0x190F1E3C),
                    borderRadius: BorderRadius.circular(4),
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
