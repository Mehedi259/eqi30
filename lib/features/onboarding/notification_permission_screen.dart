import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/services/notification_service.dart';

/// Dedicated Notification Opt-In Screen before creating/signing into account.
class NotificationPermissionScreen extends StatefulWidget {
  const NotificationPermissionScreen({super.key});

  @override
  State<NotificationPermissionScreen> createState() =>
      _NotificationPermissionScreenState();
}

class _NotificationPermissionScreenState
    extends State<NotificationPermissionScreen> {
  bool _isRequesting = false;

  Future<void> _enableNotifications() async {
    setState(() => _isRequesting = true);
    try {
      await NotificationService().requestPermissions();
      await NotificationService().scheduleEndOfDayReflectionReminder();
      await NotificationService().scheduleInactivityNudge(2);
    } catch (e) {
      debugPrint('Notification permission request error: $e');
    } finally {
      if (mounted) {
        setState(() => _isRequesting = false);
        context.go('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  if (context.canPop()) context.pop();
                },
                icon: const Icon(Icons.arrow_back, color: Color(0xFF0B191D)),
              ),
              const SizedBox(height: 12),
              Center(
                child: Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F7F9),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.notifications_active_outlined,
                    size: 42,
                    color: Color(0xFF073B4B),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Center(
                child: Text(
                  'Stay Gentle & Consistent',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF0B191D),
                    fontSize: 24,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  'Allow notifications so Ember can keep your 5-minute habit on track without overwhelm.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF637275),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              _benefitTile(
                Icons.alarm_outlined,
                'Daily Practice Anchor',
                'A single timely reminder during your chosen practice window.',
              ),
              const SizedBox(height: 14),
              _benefitTile(
                Icons.nights_stay_outlined,
                'End-of-Day Reflection Check',
                'A quick evening nudge if you practiced today and haven\'t saved your reflection yet.',
              ),
              const SizedBox(height: 14),
              _benefitTile(
                Icons.favorite_outline,
                'Supportive Comeback Nudge',
                'A gentle check-in if you miss a couple of days based on your commitment pace.',
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isRequesting ? null : _enableNotifications,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF073B4B),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: _isRequesting
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Turn On Reminders & Continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: TextButton(
                  onPressed: _isRequesting ? null : () => context.go('/login'),
                  child: const Text(
                    'Not right now',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _benefitTile(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF0FAFB),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 22, color: const Color(0xFF249FA9)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF0B191D),
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 12.5,
                    fontFamily: 'Inter',
                    height: 1.4,
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

