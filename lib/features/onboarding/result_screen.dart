import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/services/onboarding_service.dart';

class OnboardingResultScreen extends StatefulWidget {
  const OnboardingResultScreen({super.key});

  @override
  State<OnboardingResultScreen> createState() => _OnboardingResultScreenState();
}

class _OnboardingResultScreenState extends State<OnboardingResultScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _progressController;
  late Animation<double> _headerAnimation;
  late Animation<double> _cardAnimation;
  late Animation<double> _buttonAnimation;

  // Progress animations for each card
  List<Animation<double>> _progressAnimations = [];
  
  bool _isLoading = true;
  List<Map<String, dynamic>> _results = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _progressController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    _headerAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );

    _cardAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.7, curve: Curves.easeOut),
      ),
    );

    _buttonAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
      ),
    );

    _fetchResults();
  }

  Future<void> _fetchResults() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final sessionId = prefs.getString('onboarding_session_id');
      if (sessionId != null) {
        final response = await OnboardingService().getAssessmentResult(sessionId);
        debugPrint('Assessment response: $response');
        if (response.containsKey('results')) {
          final results = List<Map<String, dynamic>>.from(response['results']);
          results.sort((a, b) => (a['ai_priority'] as int).compareTo(b['ai_priority'] as int));
          
          if (mounted) {
            setState(() {
              _results = results;
              _isLoading = false;
            });
            _setupAnimations();
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
          {'competency': 'SELF_MANAGEMENT', 'score': 42.0},
          {'competency': 'STRESS_MANAGEMENT', 'score': 55.0},
          {'competency': 'INTERPERSONAL_MANAGEMENT', 'score': 65.0},
          {'competency': 'SPIRIT_MANAGEMENT', 'score': 78.0},
          {'competency': 'EXECUTIVE_FUNCTION', 'score': 85.0},
          {'competency': 'DECISION_MAKING', 'score': 92.0},
        ];
      });
      _setupAnimations();
    }
  }

  void _setupAnimations() {
    _progressAnimations = [];
    
    for (int i = 0; i < _results.length; i++) {
      double score = (_results[i]['score'] as num).toDouble();
      double targetValue = score / 100.0;
      
      double startInterval = i * 0.1;
      double endInterval = startInterval + 0.4;
      if (endInterval > 1.0) endInterval = 1.0;
      
      _progressAnimations.add(Tween<double>(begin: 0.0, end: targetValue).animate(
        CurvedAnimation(
          parent: _progressController,
          curve: Interval(startInterval, endInterval, curve: Curves.easeOutCubic),
        ),
      ));
    }

    _controller.forward();

    // Start progress animations after cards appear
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        _progressController.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAFC),
        elevation: 0,
        leading: IconButton(
          icon: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(Icons.arrow_back, size: 16, color: Colors.black),
          ),
          onPressed: () => context.canPop()
              ? context.pop()
              : context.go('/ai-chat-onboarding'),
        ),
        title: const Text(
          'Result',
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
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(26, 26, 26, 48),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Animated Header
            FadeTransition(
              opacity: _headerAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '✦ YOUR EQ SNAPSHOT',
                    style: TextStyle(
                      color: Color(0xFF50A8C0),
                      fontSize: 11,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.10,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Here are you results',
                    style: TextStyle(
                      color: Color(0xFF1A2B4A),
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Animated Cards
            FadeTransition(
              opacity: _cardAnimation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.2),
                  end: Offset.zero,
                ).animate(_cardAnimation),
                child: Column(
                  children: List.generate(_results.length, (index) {
                    final item = _results[index];
                    final rawName = item['competency'] as String;
                    // Use competency_name from API if available, else format from code
                    final title = (item['competency_name'] as String?)?.isNotEmpty == true
                        ? item['competency_name'] as String
                        : rawName.split('_').map((w) => w.isNotEmpty ? w[0].toUpperCase() + w.substring(1).toLowerCase() : '').join(' ');
                    
                    final score = (item['score'] as num).toDouble();
                    
                    String status = 'Developing';
                    if (score < 50) status = 'Needs Attention';
                    else if (score >= 50 && score < 65) status = 'Developing';
                    else if (score >= 65 && score < 75) status = 'Good';
                    else status = 'Strong';
                    
                    final progressAnimation = _progressAnimations.length > index ? _progressAnimations[index] : const AlwaysStoppedAnimation(0.0);
                    
                    Color mainColor = const Color(0xFF249FA9);
                    if (score < 50) mainColor = const Color(0xFF43BDC7);
                    else if (score >= 50 && score < 65) mainColor = const Color(0xFF249FA9);
                    else if (score >= 65 && score < 75) mainColor = const Color(0xFF43C76F);
                    else if (score >= 75 && score < 80) mainColor = const Color(0xFFF37C21);
                    else if (score >= 80 && score < 90) mainColor = const Color(0xFF96B6F0);
                    else mainColor = const Color(0xFF6A95E2);

                    return Column(
                      children: [
                        AnimatedBuilder(
                          animation: progressAnimation,
                          builder: (context, child) {
                            if (index == 0) {
                              return _buildHighlightedCard(
                                title,
                                status,
                                (progressAnimation.value * 100).toInt(),
                                progressAnimation.value,
                                mainColor,
                                const Color(0xFFEBFDFF),
                                const Color(0xFF002B2E),
                                showBadge: true,
                              );
                            } else {
                              return _buildResultCard(
                                title,
                                status,
                                (progressAnimation.value * 100).toInt(),
                                progressAnimation.value,
                                mainColor,
                              );
                            }
                          },
                        ),
                        if (index < _results.length - 1) const SizedBox(height: 12),
                      ],
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Animated Buttons
            FadeTransition(
              opacity: _buttonAnimation,
              child: Column(
                children: [
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Improve your skills in under 5 minutes daily\n',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: 'See your recommended journey',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    style: TextStyle(
                      color: Color(0xFF0B191D),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      height: 1.43,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => context.go('/journey-details'),
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
                            'START',
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
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => context.go('/custom-journey-onboarding'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(
                          color: Color(0xFF637275),
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Build my own journey',
                            style: TextStyle(
                              color: Color(0xFF637275),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 12),
                          Icon(
                            Icons.arrow_forward,
                            size: 16,
                            color: Color(0xFF637275),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }

  Widget _buildHighlightedCard(
    String title,
    String status,
    int percentage,
    double progressValue,
    Color color,
    Color bgColor,
    Color borderColor, {
    bool showBadge = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 36, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF0B191D),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      status,
                      style: TextStyle(
                        color: color,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(9999),
                  child: LinearProgressIndicator(
                    value: progressValue,
                    backgroundColor: const Color(0xFF073B4B),
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    minHeight: 8,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Highest opportunity for growth',
                      style: TextStyle(
                        color: Color(0xFF509BA1),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '$percentage%',
                      style: const TextStyle(
                        color: Color(0xFF073B4B),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (showBadge)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFF002B2E),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: const Text(
                  'Start from here',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildResultCard(
    String title,
    String status,
    int percentage,
    double progressValue,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE4E2E5)),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF0B191D),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(9999),
            child: LinearProgressIndicator(
              value: progressValue,
              backgroundColor: const Color(0xFFEFEDF0),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$percentage%',
            style: const TextStyle(
              color: Color(0xFF637275),
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
