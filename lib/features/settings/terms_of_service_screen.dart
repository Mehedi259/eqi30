import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

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
                          BoxShadow(color: Color(0x14073B4B), blurRadius: 4),
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
                      'Terms of Service',
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
                      title: 'Acceptance of Terms',
                      content: [
                        'By downloading, installing, or using the EQi30 app, you agree to be bound by these Terms of Service. If you do not agree, please do not use the app.',
                      ],
                    ),
                    _buildSection(
                      number: '2',
                      title: 'Eligibility',
                      content: [
                        'You must be 18 years or older to use EQi30. By creating an account, you confirm that you meet this requirement.',
                      ],
                    ),
                    _buildSection(
                      number: '3',
                      title: 'Your Account',
                      content: [
                        'You are responsible for maintaining the confidentiality of your login credentials.',
                        'You are responsible for all activity that occurs under your account.',
                        'Notify us immediately at support@eqi30.com if you suspect unauthorized access.',
                      ],
                    ),
                    _buildSection(
                      number: '4',
                      title: 'No Professional Liability',
                      content: [
                        'You agree not to:',
                        '• Use the app for any unlawful or harmful purpose.',
                        '• Attempt to hack, reverse engineer, or disrupt the app or its servers.',
                        '• Share, copy, or distribute any app content without permission.',
                        '• Impersonate another person or misrepresent your identity.',
                        '• Upload any offensive, abusive, or inappropriate content.',
                      ],
                    ),
                    _buildSection(
                      number: '5',
                      title: 'Intellectual Property',
                      content: [
                        'All content within EQi30 — including the EQ framework, exercises, content, illustrations, and app design — is the intellectual property of EQi30 and its licensors. You may not copy, reproduce, distribute, or create derivative works from the app without prior written consent.',
                      ],
                    ),
                    _buildSection(
                      number: '6',
                      title: 'Health & Professional Disclaimer',
                      content: [
                        'EQi30 is a self-development and skill-building tool. It is not a substitute for professional mental health treatment, therapy, or medical advice. If you are experiencing a mental health crisis, please seek help from a licensed mental health professional.',
                      ],
                    ),
                    _buildSection(
                      number: '7',
                      title: 'Termination',
                      content: [
                        'We reserve the right to suspend or terminate your account at any time if you violate these Terms. You may delete your account at any time via Profile → Settings → Security → Delete Account.',
                      ],
                    ),
                    _buildSection(
                      number: '8',
                      title: 'Limitation of Liability',
                      content: [
                        'EQi30 is provided "as is" without warranties of any kind. We are not liable for any direct, indirect, incidental, or consequential damages arising from your use of the app.',
                      ],
                    ),
                    _buildSection(
                      number: '9',
                      title: 'Changes to These Terms',
                      content: [
                        'We may update these Terms periodically. Continued use of the app after changes are posted or announced means you accept the new terms. We\'ll notify you of significant changes via in-app notification or email.',
                      ],
                    ),
                    _buildSection(
                      number: '10',
                      title: 'Contact Us',
                      content: [
                        'For any questions regarding these Terms:',
                        '✉ privacy@eqi30.com  🌐 www.eqi30.com',
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
        boxShadow: const [BoxShadow(color: Color(0x14073B4B), blurRadius: 4)],
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
          ...content.map(
            (text) => Padding(
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
            ),
          ),
        ],
      ),
    );
  }
}
