import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/services/learning_service.dart';
import '../core/services/journey_service.dart';
import 'learning_screen.dart';

class StartJourneyScreen extends StatefulWidget {
  final int sessionId;
  final int abilityId;
  final int dayNumber;
  final String abilityName;

  const StartJourneyScreen({
    super.key,
    required this.sessionId,
    required this.abilityId,
    required this.dayNumber,
    required this.abilityName,
  });

  @override
  State<StartJourneyScreen> createState() => _StartJourneyScreenState();
}

class _StartJourneyScreenState extends State<StartJourneyScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _pulseController;
  late AnimationController _shimmerController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _headerSlideAnimation;
  late Animation<Offset> _categorySlideAnimation;
  late Animation<double> _card1FadeAnimation;
  late Animation<double> _card2FadeAnimation;
  late Animation<double> _card3FadeAnimation;
  late Animation<Offset> _detailsSlideAnimation;
  late Animation<Offset> _learnSlideAnimation;
  late Animation<double> _phaseFadeAnimation;
  late Animation<Offset> _buttonSlideAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _shimmerAnimation;
  late Animation<double> _scaleAnimation;

  final LearningService _learningService = LearningService();
  final JourneyService _journeyService = JourneyService();
  bool _isLoading = true;
  Map<String, dynamic>? _competencyData;
  Map<String, dynamic>? _dashboardData;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1600),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat();

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
      ),
    );

    _headerSlideAnimation =
        Tween<Offset>(begin: const Offset(0, -0.5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.4, curve: Curves.easeOutCubic),
          ),
        );

    _categorySlideAnimation =
        Tween<Offset>(begin: const Offset(-0.5, 0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.1, 0.4, curve: Curves.easeOutCubic),
          ),
        );

    _card1FadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.5, curve: Curves.easeIn),
      ),
    );

    _card2FadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.25, 0.55, curve: Curves.easeIn),
      ),
    );

    _card3FadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.6, curve: Curves.easeIn),
      ),
    );

    _detailsSlideAnimation =
        Tween<Offset>(begin: const Offset(0.3, 0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.35, 0.65, curve: Curves.easeOutCubic),
          ),
        );

    _learnSlideAnimation =
        Tween<Offset>(begin: const Offset(-0.3, 0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.4, 0.7, curve: Curves.easeOutCubic),
          ),
        );

    _phaseFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.85, curve: Curves.easeIn),
      ),
    );

    _buttonSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.6, 1.0, curve: Curves.elasticOut),
          ),
        );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _shimmerAnimation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.linear),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
  }

  Future<void> _fetchData() async {
    try {
      final results = await Future.wait([
        _learningService.getAbilityCompetencyIntro(widget.abilityId),
        _journeyService.getHomeDashboard(),
      ]);
      if (mounted) {
        setState(() {
          _competencyData = results[0];
          _dashboardData = results[1];
          _isLoading = false;
        });
        _controller.forward();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _pulseController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: _isLoading 
                ? const Center(child: CircularProgressIndicator(color: AppColors.primaryDark))
                : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    _buildCategoryRow(),
                    const SizedBox(height: 16),
                    _buildInfoCards(),
                    const SizedBox(height: 16),
                    _buildJourneyDetails(),
                    const SizedBox(height: 24),
                    _buildWhatYouLearnSection(),
                    const SizedBox(height: 24),
                    _buildJourneyPhasesSection(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            if (!_isLoading) _buildBottomActions(context),
          ],
        ),
      ),
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
              currentIndex: 1, // Journey is selected
              onTap: (index) {
                if (index == 2) {
                  context.push('/chat');
                } else if (index != 1) {
                  context.go('/home?tab=$index');
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

  Widget _buildHeader(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _headerSlideAnimation,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Icon(Icons.arrow_back, size: 16),
                ),
              ),
              const Expanded(
                child: Text(
                  'Start Journey',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF0B191D),
                    fontSize: 18,
                    fontFamily: 'Archivo',
                    fontWeight: FontWeight.w600,
                    height: 1.11,
                  ),
                ),
              ),
              const SizedBox(width: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryRow() {
    final title = _competencyData?['name'] ?? 'Self Management';
    return SlideTransition(
      position: _categorySlideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedBuilder(
              animation: _shimmerAnimation,
              builder: (context, child) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0x1443BDC7),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x1443BDC7),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ShaderMask(
                    shaderCallback: (bounds) {
                      return LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: [
                          _shimmerAnimation.value - 0.3,
                          _shimmerAnimation.value,
                          _shimmerAnimation.value + 0.3,
                        ],
                        colors: const [
                          Color(0xFF43BDC7),
                          Color(0xFF6DD5DF),
                          Color(0xFF43BDC7),
                        ],
                      ).createShader(bounds);
                    },
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 1.50,
                      ),
                    ),
                  ),
                );
              },
            ),
            const Text(
              'Recommended First',
              style: TextStyle(
                color: Color(0xFF637275),
                fontSize: 11,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCards() {
    return Column(
      children: [
        FadeTransition(
          opacity: _card1FadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: _buildInfoCard(
              title: 'WHAT IT IS',
              titleColor: const Color(0xFF006767),
              description: _competencyData?['what_it_is']?.toString().isNotEmpty == true 
                  ? _competencyData!['what_it_is'] 
                  : 'Recognizing & naming what you feel in the moment.',
              width: double.infinity,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: FadeTransition(
                opacity: _card2FadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: _buildInfoCard(
                    title: 'WHY IT MATTERS',
                    titleColor: const Color(0xFFE8A54B),
                    description: _competencyData?['why_it_matters']?.toString().isNotEmpty == true 
                        ? _competencyData!['why_it_matters'] 
                        : 'Improves self-control, reduces reactivity, clarifies decisions.',
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: FadeTransition(
                opacity: _card3FadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: _buildInfoCard(
                    title: 'WHAT YOU\'LL DO',
                    titleColor: const Color(0xFF006767),
                    description: _competencyData?['what_you_will_do']?.toString().isNotEmpty == true 
                        ? _competencyData!['what_you_will_do'] 
                        : 'Short daily check-ins using simple prompts & a feelings list.',
                    width: double.infinity,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required String title,
    required Color titleColor,
    required String description,
    required double width,
  }) {
    return Container(
      width: width == double.infinity ? null : width,
      constraints: width == double.infinity
          ? const BoxConstraints(minWidth: double.infinity)
          : null,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE0EEEE)),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 16,
                decoration: BoxDecoration(
                  color: titleColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: titleColor,
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 1.33,
                  letterSpacing: 0.60,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              color: Color(0xFF3E4948),
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 1.43,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJourneyDetails() {
    return SlideTransition(
      position: _detailsSlideAnimation,
      child: FadeTransition(
        opacity: _card3FadeAnimation,
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildDetailChip('📅', '30-day journey'),
            _buildDetailChip('⏱️', '~5 min/day'),
            _buildDetailChip('🎯', '60 micro-skills total'),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailChip(String icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFDDF9F8), Color(0xFFE8F5F5)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF43BDC7).withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF43BDC7).withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF3E4948),
              fontSize: 13,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 1.43,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhatYouLearnSection() {
    List<dynamic> items = _competencyData?['what_you_will_learn'] ?? [];
    if (items.isEmpty) {
      items = [
        'Name specific emotions instead of just \'fine\'',
        'Notice emotions in your body',
        'Understand feelings vs thoughts',
        'Pause and respond vs react'
      ];
    }
    
    return SlideTransition(
      position: _learnSlideAnimation,
      child: FadeTransition(
        opacity: _phaseFadeAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What You\'ll Learn',
              style: TextStyle(
                color: Color(0xFF0B191D),
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                height: 1.44,
                letterSpacing: 0.60,
              ),
            ),
            const SizedBox(height: 16),
            ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _buildLearningItem(item.toString()),
            )).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildLearningItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: const Color(0xFF43BDC7).withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check, color: Color(0xFF43BDC7), size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF051F1F),
              fontSize: 15,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildJourneyPhasesSection() {
    List<dynamic> abilities = _competencyData?['abilities'] ?? [];
    
    // Fallback if no abilities are returned
    if (abilities.isEmpty) {
      abilities = [
        {'name': 'Emotional Awareness', 'description': 'Notice and name your emotions in real time.', 'emoji': '🧠'},
        {'name': 'Boundary Awareness', 'description': 'Know your limits and say no without guilt.', 'emoji': '🚧'},
        {'name': 'Self-Confidence', 'description': 'Trust your abilities under pressure.', 'emoji': '💪'},
        {'name': 'Self-Actualization', 'description': 'Move toward your best, not just survive.', 'emoji': '🌱'},
        {'name': 'Independence', 'description': 'Decide for yourself without over-relying on approval.', 'emoji': '🦅'},
      ];
    }
    
    return FadeTransition(
      opacity: _phaseFadeAnimation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Journey Phases',
            style: TextStyle(
              color: Color(0xFF0B191D),
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              height: 1.44,
              letterSpacing: 0.60,
            ),
          ),
          const SizedBox(height: 16),
          ...abilities.asMap().entries.map((entry) {
            int index = entry.key;
            var ability = entry.value;
            bool isActive = false;
            if (ability is Map && ability['id'] == widget.abilityId) {
              isActive = true;
            }

            int activeIndex = abilities.indexWhere((a) => a is Map && a['id'] == widget.abilityId);
            String status = '';
            int currentDay = _dashboardData?['journey']?['current_day'] ?? widget.dayNumber;
            int totalDays = _dashboardData?['journey']?['total_days'] ?? 30;

            if (activeIndex != -1 && index < activeIndex) {
              status = 'Completed';
            } else if (isActive) {
              status = 'Day $currentDay/$totalDays';
            } else {
              status = 'Not started';
            }

            // Try to extract emoji from name or description if not provided directly
            String emoji = '🧠';
            if (ability is Map && ability['emoji'] != null) {
              emoji = ability['emoji'];
            } else if (index == 0) emoji = '🧠';
            else if (index == 1) emoji = '🚧';
            else if (index == 2) emoji = '💪';
            else if (index == 3) emoji = '🌱';
            else if (index == 4) emoji = '🦅';
            
            String name = ability is Map ? ability['name'] ?? '' : ability.toString();
            String desc = ability is Map ? ability['description'] ?? '' : '';
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildPhaseCard(
                emoji: emoji,
                title: name,
                description: desc,
                status: status,
                isActive: isActive,
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildPhaseCard({
    required String emoji,
    required String title,
    required String description,
    required String status,
    required bool isActive,
  }) {
    final cardWidget = AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: isActive ? const Color(0xFF43BDC7) : const Color(0xFFE0EEEE),
          width: isActive ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isActive
                ? const Color(0xFF43BDC7).withValues(alpha: 0.15)
                : Colors.black.withValues(alpha: 0.04),
            blurRadius: isActive ? 12 : 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isActive
                    ? [const Color(0x3343BDC7), const Color(0x1A43BDC7)]
                    : [const Color(0x1AE0EEEE), const Color(0x0DE0EEEE)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(emoji, style: const TextStyle(fontSize: 28)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: const Color(0xFF1A2B4A),
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
                    height: 1.43,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF8A96A8),
                    fontSize: 13,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFFE6F5F6) : (status == 'Completed' ? const Color(0xFFE8F5E9) : const Color(0xFFF1F3F5)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: isActive ? const Color(0xFF43BDC7) : (status == 'Completed' ? Colors.green : const Color(0xFF8A96A8)),
                fontSize: 11,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );

    // Add pulse animation to active card
    if (isActive) {
      return ScaleTransition(scale: _pulseAnimation, child: cardWidget);
    }
    return cardWidget;
  }

  Widget _buildBottomActions(BuildContext context) {
    return SlideTransition(
      position: _buttonSlideAnimation,
      child: Container(
        padding: const EdgeInsets.all(26),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  context.push(
                    '/learning?sessionId=${widget.sessionId}&abilityId=${widget.abilityId}&dayNumber=${widget.dayNumber}&abilityName=${widget.abilityName}',
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF073B4B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                  shadowColor: const Color(0xFF073B4B).withValues(alpha: 0.3),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Start with first skill',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 1.50,
                      ),
                    ),
                    SizedBox(width: 12),
                    Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Text(
                'Back to home',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF637275),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                  height: 1.43,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
