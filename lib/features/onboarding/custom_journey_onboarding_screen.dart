import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomJourneyOnboardingScreen extends StatefulWidget {
  const CustomJourneyOnboardingScreen({super.key});

  @override
  State<CustomJourneyOnboardingScreen> createState() =>
      _CustomJourneyOnboardingScreenState();
}

class _CustomJourneyOnboardingScreenState
    extends State<CustomJourneyOnboardingScreen> {
  final Map<String, int?> _priorities = {
    'Self Management': 1,
    'Stress Management': 2,
    'Interpersonal Management': 3,
    'Spirit Management': 4,
    'Executive Functioning': 5,
    'Decision Making': 6,
  };

  void _setPriority(String competency, int priority) {
    setState(() {
      _priorities[competency] = priority;
    });
  }

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
              context.go('/result-onboarding');
            }
          },
        ),
        title: const Text(
          'Custom Journey',
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
              'CUSTOM JOURNEY',
              style: TextStyle(
                color: Color(0xFF006767),
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                letterSpacing: 1.20,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Build your own learning path.',
              style: TextStyle(
                color: Color(0xFF051F1F),
                fontSize: 24,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Tap the number to set the priority for each\ncompetency. 1 = start first.',
              style: TextStyle(
                color: Color(0xFF3E4948),
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
            const SizedBox(height: 16),
            
            // Info Box
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0x4CFFDDB7),
                border: Border.all(color: const Color(0xFFFFDDB7)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '💡',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'You can always switch to your AI\nrecommended journey anytime.',
                      style: TextStyle(
                        color: Color(0xFF754900),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.43,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Competency Cards
            _buildCompetencyCard(
              '🔄',
              'Self Management',
              'Master your reactions',
              const Color(0xFF43BDC7),
              const Color(0xFFD8F3F3),
              'Self Management',
            ),
            const SizedBox(height: 12),
            _buildCompetencyCard(
              '🌊',
              'Stress Management',
              'Stay calm under pressure',
              const Color(0xFF249FA9),
              const Color(0xFFD8F3F3),
              'Stress Management',
            ),
            const SizedBox(height: 12),
            _buildCompetencyCard(
              '🤝',
              'Interpersonal Management',
              'Connect with others',
              const Color(0xFF43C76F),
              const Color(0xFFD4EDDD),
              'Interpersonal Management',
            ),
            const SizedBox(height: 12),
            _buildCompetencyCard(
              '⚡',
              'Spirit Management',
              'Fuel your daily drive',
              const Color(0xFFF37C21),
              const Color(0xFFEFE0D5),
              'Spirit Management',
            ),
            const SizedBox(height: 12),
            _buildCompetencyCard(
              '🧭',
              'Executive Functioning',
              'Plan and execute',
              const Color(0xFF96B6F0),
              const Color(0xFFD4DEEF),
              'Executive Functioning',
            ),
            const SizedBox(height: 12),
            _buildCompetencyCard(
              '🎯',
              'Decision Making',
              'Navigate complex choices',
              const Color(0xFF6A95E2),
              const Color(0xFFD5DFF1),
              'Decision Making',
            ),
            const SizedBox(height: 24),
            
            // Continue Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to home
                  context.go('/home');
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
                      'Continue with my own journey',
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
            const SizedBox(height: 16),
            
            // Back Link
            Center(
              child: TextButton(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go('/result-onboarding');
                  }
                },
                child: const Text(
                  'Go back to my recommeded journey',
                  style: TextStyle(
                    color: Color(0xFF637275),
                    fontSize: 16,
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompetencyCard(
    String emoji,
    String title,
    String subtitle,
    Color borderColor,
    Color bgColor,
    String competencyKey,
  ) {
    final currentPriority = _priorities[competencyKey];
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor, width: 4),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                emoji,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF0B191D),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) {
                final priority = index + 1;
                final isSelected = currentPriority == priority;
                
                return GestureDetector(
                  onTap: () => _setPriority(competencyKey, priority),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isSelected ? borderColor : Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ]
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        '$priority',
                        style: TextStyle(
                          color: isSelected ? Colors.white : const Color(0xFF0B191D),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.60,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
