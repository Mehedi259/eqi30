import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 26,
                  vertical: 8,
                ),
                child: const Text(
                  'Profile',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF0B191D),
                    fontSize: 18,
                    fontFamily: 'Archivo',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Profile Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(color: Color(0x14073B4B), blurRadius: 20),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Avatar
                      Container(
                        width: 56,
                        height: 56,
                        decoration: const BoxDecoration(
                          color: Color(0xFF073B4B),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            'A',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Name and Sign in
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  'Alex Johnson',
                                  style: TextStyle(
                                    color: Color(0xFF1A1D23),
                                    fontSize: 18,
                                    fontFamily: 'Archivo',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.edit,
                                  size: 16,
                                  color: Color(0xFF637275),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Sign in to save your progress >',
                              style: TextStyle(
                                color: Color(0xFFF37C21),
                                fontSize: 14,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Settings List
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black.withValues(alpha: 0.06),
                      width: 0.8,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(color: Color(0x14073B4B), blurRadius: 4),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildSettingItem(
                        icon: '🎯',
                        title: 'Goal',
                        trailing: '60 min / day',
                        onTap: () => context.push('/goal'),
                      ),
                      _buildDivider(),
                      _buildSettingItem(
                        icon: '⏰',
                        title: 'Reminder',
                        trailing: '09:00',
                        onTap: () => context.push('/reminder'),
                      ),
                      _buildDivider(),
                      _buildSettingItem(
                        icon: '💳',
                        title: 'Manage Subscription',
                        onTap: () => context.push('/subscription'),
                      ),
                      _buildDivider(),
                      _buildSettingItem(
                        icon: '🔒',
                        title: 'Security',
                        onTap: () => context.push('/security'),
                      ),
                      _buildDivider(),
                      _buildSettingItem(
                        icon: '📄',
                        title: 'Privacy & Terms',
                        onTap: () => context.push('/privacy-terms'),
                      ),
                      _buildDivider(),
                      _buildSettingItem(
                        icon: '❗',
                        title: 'Help & FAQ',
                        onTap: () => context.push('/help-faq'),
                        showBorder: false,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Log Out Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: GestureDetector(
                  onTap: () {
                    // Show logout confirmation dialog
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Log Out'),
                        content: const Text(
                          'Are you sure you want to log out?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              context.go('/login');
                            },
                            child: const Text(
                              'Log Out',
                              style: TextStyle(color: Color(0xFFDC2626)),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(color: Color(0x269B9B9B), blurRadius: 4),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.logout, color: Color(0xFFDC2626), size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Log Out',
                          style: TextStyle(
                            color: Color(0xFFDC2626),
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required String icon,
    required String title,
    String? trailing,
    required VoidCallback onTap,
    bool showBorder = true,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(icon, style: const TextStyle(fontSize: 24)),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF0B191D),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                if (trailing != null)
                  Text(
                    trailing,
                    style: const TextStyle(
                      color: Color(0xFF637275),
                      fontSize: 14,
                      fontFamily: 'Inter',
                    ),
                  ),
                const SizedBox(width: 6),
                const Icon(
                  Icons.chevron_right,
                  color: Color(0xFF637275),
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(height: 1, color: Colors.black.withValues(alpha: 0.04));
  }
}
