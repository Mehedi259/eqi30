import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TimePreferenceScreen extends StatefulWidget {
  const TimePreferenceScreen({super.key});

  @override
  State<TimePreferenceScreen> createState() => _TimePreferenceScreenState();
}

class _TimePreferenceScreenState extends State<TimePreferenceScreen>
    with SingleTickerProviderStateMixin {
  String selectedTime = 'morning';
  bool dailyReminder = true;
  bool missDayNudge = true;
  late AnimationController _controller;
  late Animation<Offset> _headerSlideAnimation;
  late Animation<Offset> _morningSlideAnimation;
  late Animation<Offset> _middaySlideAnimation;
  late Animation<Offset> _eveningSlideAnimation;
  late Animation<Offset> _flexibleSlideAnimation;
  late Animation<Offset> _settingsSlideAnimation;
  late Animation<Offset> _continueButtonSlideAnimation;
  late Animation<Offset> _abilitiesButtonSlideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Very subtle upward slide with smooth fade - same as journey-details
    _headerSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.02),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _morningSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.02),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _middaySlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.02),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _eveningSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.02),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _flexibleSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.02),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _settingsSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.02),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _continueButtonSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.02),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _abilitiesButtonSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.02),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Smooth, slow fade animation
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                    // Header - Slides from left
                    SlideTransition(
                      position: _headerSlideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '✦ YOUR EQ SNAPSHOT',
                              style: TextStyle(
                                color: Color(0xFF50A8C0),
                                fontSize: 11,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.10,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'When do practices fit best into your day?',
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
                              'We\'ll send a gentle reminder. You can change this anytime.',
                              style: TextStyle(
                                color: Color(0xFF8A96A8),
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Morning - Slides from right
                    SlideTransition(
                      position: _morningSlideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: _buildTimeOption(
                          'morning',
                          '🌅',
                          'Morning',
                          '6:00 – 9:00 AM',
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Midday - Slides from left
                    SlideTransition(
                      position: _middaySlideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: _buildTimeOption(
                          'midday',
                          '☀️',
                          'Midday',
                          '11:00 AM – 2:00 PM',
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Evening - Slides from right
                    SlideTransition(
                      position: _eveningSlideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: _buildTimeOption(
                          'evening',
                          '🌙',
                          'Evening',
                          '7:00 – 10:00 PM',
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Flexible - Slides from left
                    SlideTransition(
                      position: _flexibleSlideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: _buildTimeOption(
                          'flexible',
                          '🗓',
                          'I\'ll decide each day',
                          'No fixed reminder',
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Settings container - Slides from right
                    SlideTransition(
                      position: _settingsSlideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              _buildToggleOption(
                                emoji: '🔔',
                                title: 'Daily reminder',
                                subtitle: 'At your selected time',
                                value: dailyReminder,
                                onChanged: (val) =>
                                    setState(() => dailyReminder = val),
                              ),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    top: BorderSide(color: Color(0xFFF5F0E8)),
                                    bottom: BorderSide(
                                      color: Color(0xFFF5F0E8),
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Text(
                                      '📅',
                                      style: TextStyle(fontSize: 22),
                                    ),
                                    const SizedBox(width: 14),
                                    const Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Add to calendar',
                                            style: TextStyle(
                                              color: Color(0xFF1A2B4A),
                                              fontSize: 14,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            '5-min practice block daily',
                                            style: TextStyle(
                                              color: Color(0xFF8A96A8),
                                              fontSize: 12,
                                              fontFamily: 'Inter',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF0F1E3C),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Text(
                                        'Connect',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              _buildToggleOption(
                                emoji: '💬',
                                title: 'Miss-day nudge',
                                subtitle: 'Gentle reminder if 2 days pass',
                                value: missDayNudge,
                                onChanged: (val) =>
                                    setState(() => missDayNudge = val),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(26),
              child: Column(
                children: [
                  // Continue button - Slides from left
                  SlideTransition(
                    position: _continueButtonSlideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            context.go('/login');
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
                                'CONTINUE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 12),
                              Icon(
                                Icons.arrow_forward,
                                size: 16,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Abilities button - Slides from right
                  SlideTransition(
                    position: _abilitiesButtonSlideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            context.push('/choose-journey');
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 13,
                            ),
                            side: BorderSide(
                              color: Colors.black.withOpacity(0.20),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'See 30 Abilities',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.55),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeOption(
    String value,
    String emoji,
    String title,
    String subtitle,
  ) {
    final isSelected = selectedTime == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTime = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFDCF7FB) : Colors.white,
          border: Border.all(
            width: 2,
            color: isSelected ? const Color(0xFF50A8C0) : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: const Color(0xFFEAFCFF),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 22)),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                      fontSize: 12,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF50A8C0) : null,
                border: Border.all(
                  width: 2,
                  color: isSelected
                      ? const Color(0xFF50A8C0)
                      : const Color(0xFFDDDDDD),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleOption({
    required String emoji,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF5F0E8))),
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 14),
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
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF8A96A8),
                    fontSize: 12,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF50A8C0),
          ),
        ],
      ),
    );
  }
}
