import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/constants/feelings_wheel_data.dart';
import '../core/services/profile_service.dart';
import '../core/services/journey_service.dart';
import '../core/services/learning_service.dart';

class CompleteJourneyScreen extends StatefulWidget {
  final int sessionId;
  final Map<String, dynamic>? dayContent;

  const CompleteJourneyScreen({
    super.key, 
    required this.sessionId,
    this.dayContent,
  });

  @override
  State<CompleteJourneyScreen> createState() => _CompleteJourneyScreenState();
}

class _CompleteJourneyScreenState extends State<CompleteJourneyScreen> {
  String? selectedFeeling;
  
  bool _isLoading = true;
  String _name = 'User';
  int _streak = 0;
  final ProfileService _profileService = ProfileService();
  final JourneyService _journeyService = JourneyService();
  final LearningService _learningService = LearningService();

  @override
  void initState() {
    super.initState();
    selectedFeeling = widget.dayContent?['selected_feeling']?.toString();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final results = await Future.wait([
        _profileService.getProfile(),
        _journeyService.getHomeDashboard(),
      ]);
      if (mounted) {
        setState(() {
          final profileData = results[0];
          final dashboardData = results[1];
          String fullName = profileData['full_name'] ?? profileData['name'] ?? 'User';
          if (fullName.isEmpty) fullName = 'User';
          _name = fullName.split(' ')[0]; // Use first name
          _streak = dashboardData['streak_days'] ?? 0;
          _isLoading = false;
        });
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: _isLoading 
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    _buildSuccessIcon(),
                    const SizedBox(height: 24),
                    _buildTitle(),
                    const SizedBox(height: 24),
                    _buildStreakBadge(),
                    const SizedBox(height: 32),
                    _buildQuestion(),
                    const SizedBox(height: 16),
                    _buildFeelingOptions(),
                    const SizedBox(height: 24),
                    _buildMotivationalText(),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
            _buildBottomButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back, size: 18),
            ),
          ),
          Expanded(
            child: Text(
              widget.dayContent?['ability_name']?.toString() ?? 'Practice Complete',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF0B191D),
                fontSize: 18,
                fontFamily: 'Archivo',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 32),
        ],
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return SizedBox(
      width: 120,
      height: 120,
      child: Center(
        child: Image.asset(
          'assets/images/Practice complete top icon.png',
          width: 120,
          height: 120,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        const Text(
          'Practice complete,',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF0B191D),
            fontSize: 28,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          '$_name!',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF0B191D),
            fontSize: 28,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildStreakBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF3C7),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: const Color(0xFFFDE68A), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🔥', style: TextStyle(fontSize: 20)),
          const SizedBox(width: 8),
          Text(
            '$_streak-day streak - you\'re on a roll!',
            style: const TextStyle(
              color: Color(0xFFD97706),
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestion() {
    // Determine the reflection question.
    // If the backend doesn't provide one, fallback to a dynamic estimated_minutes text.
    String question = 'How did that exercise feel?';
    if (widget.dayContent != null) {
      final reflection = widget.dayContent!['reflection_question'];
      final minutes = widget.dayContent!['estimated_minutes'] ?? 5;
      
      if (reflection != null && reflection.toString().isNotEmpty) {
        question = reflection.toString();
      } else {
        question = 'How did that $minutes-minute exercise feel?';
      }
    }

    return Text(
      question,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Color(0xFF637275),
        fontSize: 16,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
      ),
    );
  }

  static const Set<String> _legacyOutcomeLabels = {
    'More calm',
    'More clear',
    'More focused',
    'No change yet',
  };

  Widget _buildFeelingOptions() {
    List<dynamic> options = [];
    if (widget.dayContent != null && widget.dayContent!['practice_options'] != null) {
      options = widget.dayContent!['practice_options'] as List<dynamic>;
    }
    final hasLegacy = options.any(
      (o) => o is Map && _legacyOutcomeLabels.contains((o['label'] ?? '').toString()),
    );
    if (options.isEmpty || hasLegacy) {
      options = FeelingsWheelData.defaultQuickFeelings.take(4).toList();
    }

    // Since options length might vary, we can generate rows of 2.
    List<Widget> rows = [];
    for (int i = 0; i < options.length; i += 2) {
      Widget card1 = _buildFeelingCard(
        options[i]['emoji'] ?? '', 
        options[i]['label'] ?? ''
      );
      
      Widget card2 = (i + 1 < options.length) 
          ? _buildFeelingCard(options[i + 1]['emoji'] ?? '', options[i + 1]['label'] ?? '')
          : const SizedBox.shrink();

      rows.add(
        Row(
          children: [
            Expanded(child: card1),
            if (i + 1 < options.length) const SizedBox(width: 12),
            if (i + 1 < options.length) Expanded(child: card2),
          ],
        ),
      );
      if (i + 2 < options.length) {
        rows.add(const SizedBox(height: 12));
      }
    }

    rows.add(const SizedBox(height: 10));
    rows.add(
      TextButton.icon(
        onPressed: () {
          showFeelingsWheelPickerSheet(
            context: context,
            selectedWord: selectedFeeling,
            onSelected: (word) => setState(() => selectedFeeling = word),
          );
        },
        icon: const Icon(Icons.explore_outlined, size: 18, color: Color(0xFF073B4B)),
        label: Text(
          selectedFeeling != null &&
                  !FeelingsWheelData.defaultQuickFeelings
                      .take(4)
                      .any((f) => f['label'] == selectedFeeling)
              ? 'Selected from Feelings Wheel: $selectedFeeling (Change)'
              : 'Explore full 7-group Feelings Wheel',
          style: const TextStyle(
            color: Color(0xFF073B4B),
            fontSize: 13,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );

    return Column(children: rows);
  }

  Widget _buildFeelingCard(String emoji, String label) {
    final isSelected = selectedFeeling == label;

    return GestureDetector(
      onTap: () => setState(() => selectedFeeling = label),
      child: Container(
        height: 110,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE0F2F1) : const Color(0xFFE5E7EB),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF3D8C8C) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 36)),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF0B191D),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMotivationalText() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        'Small daily practices like this are how your EQi30 abilities grow — week by week, not all at once.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF637275),
          fontSize: 14,
          fontFamily: 'Inter',
          fontStyle: FontStyle.italic,
          height: 1.5,
        ),
      ),
    );
  }

  Future<void> _handleSaveAndNextOrExit() async {
    if (widget.sessionId > 0) {
      if (selectedFeeling != null && selectedFeeling!.isNotEmpty) {
        try {
          await _learningService.submitReflection(
            widget.sessionId,
            response: selectedFeeling!,
          );
        } catch (e) {
          debugPrint('Error saving feeling response: $e');
        }
      }

      try {
        await _learningService.completeSession(widget.sessionId);
      } catch (e) {
        debugPrint('Error completing session: $e');
      }
    }

    try {
      final results = await Future.wait([
        _journeyService.getHomeDashboard(),
        _journeyService.getTodayJourney(),
      ]);
      final dashboardData = results[0];
      final todayData = results[1];
      final status = dashboardData['journey']?['status'];
      final sessions = (todayData['sessions'] as List<dynamic>?) ?? [];
      Map<String, dynamic>? nextSession;
      for (final s in sessions) {
        if (s is Map<String, dynamic> &&
            s['status'] != 'COMPLETED' &&
            s['session_id'] != widget.sessionId) {
          nextSession = s;
          break;
        }
      }

      if (!mounted) return;
      if (status == 'COMPLETED') {
        context.go('/journey-completed');
        return;
      }
      if (nextSession != null) {
        final nextAbility = nextSession['ability'] as Map<String, dynamic>? ?? {};
        final nextName = nextAbility['name']?.toString() ?? 'your next ability';
        final shouldStartNext = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Text(
              'Great job! Ready for the next skill?',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 18),
            ),
            content: Text(
              'You still have "$nextName" scheduled for today. Would you like to move right into it now?',
              style: const TextStyle(fontFamily: 'Inter', fontSize: 14, color: Color(0xFF475569)),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text('Save & Exit'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF073B4B),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Start Next Ability'),
              ),
            ],
          ),
        );
        if (!mounted) return;
        if (shouldStartNext == true) {
          final nextRoute = Uri(
            path: '/session-intro',
            queryParameters: {
              'sessionId': '${nextSession['session_id'] ?? 0}',
              'abilityId': '${nextAbility['id'] ?? 1}',
              'dayNumber': '${nextSession['content_day'] ?? 1}',
              'abilityName': nextName,
            },
          ).toString();
          context.go(nextRoute);
          return;
        }
      }
      context.go('/home?tab=1');
    } catch (e) {
      debugPrint('Error navigating after save: $e');
      if (mounted) context.go('/home?tab=1');
    }
  }

  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.all(26),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go('/home?tab=1');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF073B4B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back, color: Colors.white, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Go Back',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: _handleSaveAndNextOrExit,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF073B4B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Save and Exit',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
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
}
