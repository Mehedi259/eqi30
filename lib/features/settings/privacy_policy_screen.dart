import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x14073B4B),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFF0B191D),
                        size: 20,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Privacy Policy',
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
            ),

            const SizedBox(height: 16),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSection(
                      number: '1',
                      title: 'Information We Collect',
                      content: [
                        'Account info — Name, email address, and password.',
                        'Assessment Responses — Your EQ competency ratings and reassessment results.',
                        'Practice Data — Abilities you choose, exercises submitted during daily practice.',
                        'Usage & Device Data — App activity, device type, completed exercises, and app activity.',
                        'Device Info — Device type, OS version, and time-session for technical support.',
                      ],
                    ),
                    _buildSection(
                      number: '2',
                      title: 'How We Use Your Information',
                      content: [
                        'To create and manage your account.',
                        'To personalize your journey: recommendations based on your progress, choices, and milestone achievements.',
                        'To send practice reminders, notifications about your chosen times.',
                        'To improve our features, fix bugs, and enhance user experience.',
                        'To provide EQi30 services based on your inputs.',
                      ],
                    ),
                    _buildSection(
                      number: '3',
                      title: 'How We Use Your Information',
                      content: [
                        'We do not sell your personal data to any third party.',
                        'Trusted service providers (hosting, analytics, notification services) may access data to operate the app.',
                        'If you choose EQi30 through a coaching program or organizational partner, they may see aggregated progress data — never raw private data.',
                        'Data may be disclosed if required by law or to protect user safety.',
                      ],
                    ),
                    _buildSection(
                      number: '4',
                      title: 'Data Storage and Security',
                      content: [
                        'Your data is stored on secure, encrypted cloud servers.',
                        'All data in transit is protected using HTTPS/ TLS encryption.',
                        'If you delete your account, all personal data is permanently removed within 30 days.',
                      ],
                    ),
                    _buildSection(
                      number: '5',
                      title: 'Your Rights',
                      content: [
                        'Access — Request a copy of your data anytime.',
                        'Correction — Update your info via Profile.',
                        'Deletion — Delete your account via Profile → Settings → Security.',
                        'Opt-Out — Turn off notifications anytime from Profile → Notifications.',
                      ],
                    ),
                    _buildSection(
                      number: '6',
                      title: 'Children\'s Privacy',
                      content: [
                        'EQi30 is intended for users 18 and older. We do not knowingly collect data from anyone under 18.',
                      ],
                    ),
                    _buildSection(
                      number: '7',
                      title: 'Changes to This Policy',
                      content: [
                        'We may update this policy periodically. Any significant changes will be communicated via in-app notification or email. Continued use of the app after changes means you accept the revised policy.',
                      ],
                    ),
                    _buildSection(
                      number: '8',
                      title: 'Contact Us',
                      content: [
                        'For any privacy-related questions or requests:',
                        '✉ privacy@eqi30.com  🌐 www.eqi30.com',
                        'Respond to us at any time within 3 business days.',
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String number,
    required String title,
    required List<String> content,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14073B4B),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$number. ',
                style: const TextStyle(
                  color: Color(0xFF095A70),
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF0B191D),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...content.map((text) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  text.startsWith('•') ? text : '• $text',
                  style: const TextStyle(
                    color: Color(0xFF637275),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    height: 1.5,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
