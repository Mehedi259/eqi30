import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HelpFaqScreen extends StatefulWidget {
  const HelpFaqScreen({super.key});

  @override
  State<HelpFaqScreen> createState() => _HelpFaqScreenState();
}

class _HelpFaqScreenState extends State<HelpFaqScreen> {
  int? expandedIndex;

  final List<Map<String, String>> faqs = [
    {
      'question': 'What is EQi30?',
      'answer':
          'EQi30 is a mobile app that helps professionals and leaders build emotional intelligence through 30 trainable abilities — with structured daily 5-minute micro-skill practices.',
    },
    {
      'question': 'Who is EQi30 for?',
      'answer':
          'It\'s built for working professionals, team leaders, and organizational leaders who want to develop real emotional and leadership skills through consistent daily practice.',
    },
    {
      'question': 'How much time do I need each day?',
      'answer':
          'As little as 5 minutes. You choose your own pace — 1, 2, or 3 abilities per day depending on your commitment level.',
    },
    {
      'question': 'How do I track my progress?',
      'answer':
          'Your progress is tracked automatically through daily practice completion, ability scores, and milestone achievements. Check the Journey tab to see your growth over time.',
    },
    {
      'question': 'Can I change my subscription plan?',
      'answer':
          'Yes! Go to Profile → Manage Subscription to upgrade, downgrade, or cancel your plan at any time. Changes take effect at the start of your next billing cycle.',
    },
    {
      'question': 'How do I reset my password?',
      'answer':
          'Go to Profile → Security → Change Password. You\'ll need to enter your current password and then create a new one.',
    },
    {
      'question': 'Can I delete my account?',
      'answer':
          'Yes. Go to Profile → Security → Delete Account. Please note that this action is permanent and all your data will be removed within 30 days.',
    },
    {
      'question': 'How do I contact support?',
      'answer':
          'You can reach us at support@eqi30.com or use the Contact Support option below. We typically respond within 1-2 business days.',
    },
  ];

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
                      'Help & FAQ',
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

            const SizedBox(height: 24),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Bar
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(color: Color(0x14073B4B), blurRadius: 4),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search,
                            color: Color(0xFF637275),
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                hintText: 'Search for help...',
                                hintStyle: TextStyle(
                                  color: Color(0xFF637275),
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                              style: const TextStyle(
                                color: Color(0xFF0B191D),
                                fontSize: 14,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // FAQ Section
                    const Text(
                      'Frequently Asked Questions',
                      style: TextStyle(
                        color: Color(0xFF0B191D),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // FAQ Items
                    ...faqs.asMap().entries.map((entry) {
                      final index = entry.key;
                      final faq = entry.value;
                      final isExpanded = expandedIndex == index;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(color: Color(0x14073B4B), blurRadius: 4),
                          ],
                        ),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  expandedIndex = isExpanded ? null : index;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        faq['question']!,
                                        style: const TextStyle(
                                          color: Color(0xFF0B191D),
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      isExpanded
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down,
                                      color: const Color(0xFF637275),
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (isExpanded)
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                  bottom: 16,
                                ),
                                child: Text(
                                  faq['answer']!,
                                  style: const TextStyle(
                                    color: Color(0xFF637275),
                                    fontSize: 14,
                                    fontFamily: 'Inter',
                                    height: 1.5,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    }),

                    const SizedBox(height: 24),

                    // Contact Support Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F9FF),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF095A70).withValues(alpha: 0.2),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text('💬', style: TextStyle(fontSize: 24)),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Text(
                                  'Still need help?',
                                  style: TextStyle(
                                    color: Color(0xFF095A70),
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Can\'t find what you\'re looking for? Our support team is here to help.',
                            style: TextStyle(
                              color: const Color(
                                0xFF095A70,
                              ).withValues(alpha: 0.8),
                              fontSize: 14,
                              fontFamily: 'Inter',
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            height: 44,
                            child: ElevatedButton(
                              onPressed: () {
                                context.push('/feedback');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF095A70),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Contact Support',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
}
