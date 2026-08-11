import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PreviousJourneyScreen extends StatelessWidget {
  const PreviousJourneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAFC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0B191D)),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home');
            }
          },
        ),
        title: const Text(
          'Previous Journey',
          style: TextStyle(
            color: Color(0xFF0B191D),
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'IN PROGRESS',
              style: TextStyle(
                color: Color(0xFF38434A),
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            _buildInProgressCard(),
            const SizedBox(height: 32),
            const Text(
              'COMPLETED',
              style: TextStyle(
                color: Color(0xFF38434A),
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            _buildCompletedCard(
              emoji: '🧠',
              title: 'Emotional Awareness',
              subtitle: 'Completed 2 days ago  •  30 days',
            ),
            const SizedBox(height: 16),
            _buildCompletedCard(
              emoji: '🚧',
              title: 'Boundary Awareness',
              subtitle: 'Completed 2 weeks ago  •  15 days',
            ),
            const SizedBox(height: 16),
            _buildCompletedCard(
              emoji: '🌱',
              title: 'Self-Actualization',
              subtitle: 'Completed 1 month ago  •  7 days',
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildInProgressCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 4,
                color: const Color(0xFF2E8B57),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE5F5F8),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Text('💪', style: TextStyle(fontSize: 24)),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Self-Confidence',
                                  style: TextStyle(
                                    color: Color(0xFF0B191D),
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Day 12 of 20',
                                  style: TextStyle(
                                    color: Color(0xFF38434A),
                                    fontSize: 13,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            '60%',
                            style: TextStyle(
                              color: Color(0xFF2E8B57),
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Progress bar
                      Row(
                        children: [
                          Expanded(
                            flex: 60,
                            child: Container(
                              height: 6,
                              decoration: BoxDecoration(
                                color: const Color(0xFF2E8B57),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 40,
                            child: Container(
                              height: 6,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE9ECF1),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompletedCard({
    required String emoji,
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFFE5F5F8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 28)),
            ),
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
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF38434A),
                    fontSize: 13,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
