import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../journey/journey_tab.dart';
import '../resources/resources_tab.dart';
import '../profile/profile_tab.dart';
import 'home_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const HomeTab(),
    const JourneyTab(),
    const SizedBox(), // Chat placeholder
    const ResourcesTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowCard,
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                if (index == 2) {
                  context.push('/chat');
                } else {
                  setState(() => _currentIndex = index);
                }
              },
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: AppColors.primaryDark,
              unselectedItemColor: AppColors.textGray,
              selectedLabelStyle: AppTextStyles.caption.copyWith(
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: AppTextStyles.caption,
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/home.png',
                    width: 24,
                    height: 24,
                  ),
                  activeIcon: Image.asset(
                    'assets/images/homeActive.png',
                    width: 24,
                    height: 24,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/journey.png',
                    width: 24,
                    height: 24,
                  ),
                  activeIcon: Image.asset(
                    'assets/images/journeyActive.png',
                    width: 24,
                    height: 24,
                  ),
                  label: 'Journey',
                ),
                const BottomNavigationBarItem(
                  icon: SizedBox(height: 24),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/resource.png',
                    width: 24,
                    height: 24,
                  ),
                  activeIcon: Image.asset(
                    'assets/images/resourceActive.png',
                    width: 28,
                    height: 28,
                  ),
                  label: 'Resource',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/profile.png',
                    width: 24,
                    height: 24,
                  ),
                  activeIcon: Image.asset(
                    'assets/images/profileActive.png',
                    width: 24,
                    height: 24,
                  ),
                  label: 'Profile',
                ),
              ],
            ),
            // Floating Chat Button
            Positioned(
              top: -28,
              child: GestureDetector(
                onTap: () => context.push('/chat'),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFF8FAFC),
                      width: 6,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.primaryDark,
                    child: Image.asset(
                      'assets/images/messageActive.png',
                      width: 24,
                      height: 24,
                    ),
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
