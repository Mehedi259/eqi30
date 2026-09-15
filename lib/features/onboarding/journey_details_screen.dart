import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/services/onboarding_service.dart';

class JourneyDetailsScreen extends StatefulWidget {
  const JourneyDetailsScreen({super.key});

  @override
  State<JourneyDetailsScreen> createState() => _JourneyDetailsScreenState();
}

class _JourneyDetailsScreenState extends State<JourneyDetailsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _headerSlideAnimation;
  late Animation<Offset> _bannerSlideAnimation;
  late Animation<Offset> _nextButtonSlideAnimation;
  late Animation<Offset> _exploreButtonSlideAnimation;
  late Animation<double> _fadeAnimation;

  bool _isLoading = true;
  List<Map<String, dynamic>> _results = [];

  final Map<String, Map<String, String>> competencyImages = {
    'SELF_MANAGEMENT': {
      'before': 'assets/images/self-management-before.png',
      'after': 'assets/images/self-management-after.png',
      'name': 'Self-Management',
    },
    'DECISION_MAKING': {
      'before': 'assets/images/Decision-before.png',
      'after': 'assets/images/decetion-after.png',
      'name': 'Decision Making',
    },
    'EXECUTIVE_FUNCTION': {
      'before': 'assets/images/executive-before.png',
      'after': 'assets/images/executive-after.png',
      'name': 'Executive Functioning',
    },
    'INTERPERSONAL_MANAGEMENT': {
      'before': 'assets/images/interpersonal-before.png',
      'after': 'assets/images/inter-personal-afrer.png',
      'name': 'Interpersonal Management',
    },
    'SPIRIT_MANAGEMENT': {
      'before': 'assets/images/sprit-management-before.png',
      'after': 'assets/images/sprit-management-after.png',
      'name': 'Spirit Management',
    },
    'STRESS_MANAGEMENT': {
      'before': 'assets/images/sterss-before.png',
      'after': 'assets/images/stress-after.png',
      'name': 'Stress Management',
    },
  };

  @override
  void initState() {
    super.initState();
    _fetchResults();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Very subtle upward slide with smooth fade
    _headerSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.02),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _bannerSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.02),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _nextButtonSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.02),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _exploreButtonSlideAnimation = Tween<Offset>(
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

  Future<void> _fetchResults() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final sessionId = prefs.getString('onboarding_session_id');
      if (sessionId != null) {
        final response = await OnboardingService().getAssessmentResult(sessionId);
        if (response.containsKey('results')) {
          final results = List<Map<String, dynamic>>.from(response['results']);
          results.sort((a, b) => (a['score'] as num).compareTo(b['score'] as num));
          
          if (mounted) {
            setState(() {
              _results = results;
              _isLoading = false;
            });
            return;
          }
        }
      }
    } catch (e) {
      debugPrint('Failed to load results: $e');
    }
    
    // Fallback if failing or missing
    if (mounted) {
      setState(() {
        _isLoading = false;
        _results = [
          {'competency': 'SPIRIT_MANAGEMENT', 'score': 45.0},
          {'competency': 'STRESS_MANAGEMENT', 'score': 50.0},
          {'competency': 'INTERPERSONAL_MANAGEMENT', 'score': 55.0},
          {'competency': 'SELF_MANAGEMENT', 'score': 60.0},
          {'competency': 'DECISION_MAKING', 'score': 65.0},
          {'competency': 'EXECUTIVE_FUNCTION', 'score': 70.0},
        ];
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFD),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFBFD),
        elevation: 0,
        leading: IconButton(
          icon: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.10),
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(Icons.arrow_back, size: 16, color: Colors.black),
          ),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/result-onboarding');
            }
          },
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header - Slides from left
            SlideTransition(
              position: _headerSlideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(26, 0, 26, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Here\'s your guided journey',
                        style: TextStyle(
                          color: Color(0xFF1A2B4A),
                          fontSize: 24,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          height: 1.33,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _isLoading || _results.isEmpty
                            ? 'Loading your personalized journey...'
                            : 'We recommend working on ${competencyImages[_results.first['competency']]?['name'] ?? 'these abilities'} first',
                        style: const TextStyle(
                          color: Color(0xFF8A96A8),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 1.43,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Dynamic Journey Layout - Slides from right
            SlideTransition(
              position: _bannerSlideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: _isLoading 
                    ? const Center(child: Padding(padding: EdgeInsets.all(32), child: CircularProgressIndicator())) 
                    : Container(
                        width: size.width,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/detail-screen-background.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'BEFORE',
                                    style: TextStyle(
                                      color: Color(0xFF1A2B4A),
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    'AFTER',
                                    style: TextStyle(
                                      color: Color(0xFF1A2B4A),
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ..._results.map((result) {
                              final competencyKey = result['competency'] as String;
                              final images = competencyImages[competencyKey];
                              if (images == null) return const SizedBox.shrink();

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Image.asset(images['before']!),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 4),
                                        child: Image.asset('assets/images/arrow-icon.png', height: 24),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Image.asset(images['after']!),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
              ),
            ),

            // Buttons (now scrollable)
            SafeArea(
              top: false,
              child: Container(
                padding: const EdgeInsets.fromLTRB(26, 26, 26, 48),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Next Button - Slides from left
                    SlideTransition(
                      position: _nextButtonSlideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigate to growth pace screen
                              context.push('/growth-pace');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF073B4B),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'NEXT',
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

                    // Explore Abilities Button - Slides from right
                    SlideTransition(
                      position: _exploreButtonSlideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              // Navigate to choose journey (same as "See 30 Abilities")
                              context.push('/choose-journey');
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              side: BorderSide(
                                color: Colors.black.withOpacity(0.40),
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Explore Abilities',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.70),
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
            ),
          ],
        ),
      ),
    );
  }
}
