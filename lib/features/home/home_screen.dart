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
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.route_outlined),
                  activeIcon: Icon(Icons.route),
                  label: 'Journey',
                ),
                BottomNavigationBarItem(icon: SizedBox(height: 24), label: ''),
                BottomNavigationBarItem(
                  icon: Icon(Icons.library_books_outlined),
                  activeIcon: Icon(Icons.library_books),
                  label: 'Resource',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
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
                    child: const Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.white,
                      size: 24,
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
