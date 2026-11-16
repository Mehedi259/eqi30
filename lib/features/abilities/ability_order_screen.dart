import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/services/journey_service.dart';
import '../../core/services/onboarding_service.dart';

/// Screen 4: Explore all 30 abilities in Recommended or Chosen order,
/// pick cross-competency abilities, and prioritize Today's Practice Stack.
class AbilityOrderScreen extends StatefulWidget {
  final bool isOnboarding;
  final bool popOnSave;

  const AbilityOrderScreen({
    super.key,
    this.isOnboarding = false,
    this.popOnSave = false,
  });

  @override
  State<AbilityOrderScreen> createState() => _AbilityOrderScreenState();
}

class _AbilityOrderScreenState extends State<AbilityOrderScreen> {
  final OnboardingService _onboardingService = OnboardingService();
  final JourneyService _journeyService = JourneyService();

  bool _isLoading = true;
  bool _isSaving = false;
  String _viewMode = 'recommended'; // recommended | chosen | custom
  String _selectedCompetency = 'ALL';
  int _abilitiesPerDay = 1;
  List<Map<String, dynamic>> _abilities = [];
  List<int> _orderedIds = [];
  List<int> _manualPicks = [];

  static const List<Map<String, dynamic>> _fallbackAbilities = [
    {'id': 1, 'name': 'Emotional Awareness', 'competency': {'code': 'SELF_MANAGEMENT', 'name': 'Self-Management'}, 'what_it_is': 'Recognizing and naming what you feel in the moment.'},
    {'id': 2, 'name': 'Boundary Awareness', 'competency': {'code': 'SELF_MANAGEMENT', 'name': 'Self-Management'}, 'what_it_is': 'Understanding your personal limits and where you end and others begin.'},
    {'id': 3, 'name': 'Self-Confidence', 'competency': {'code': 'SELF_MANAGEMENT', 'name': 'Self-Management'}, 'what_it_is': 'Believing in your capacity to handle challenges.'},
    {'id': 4, 'name': 'Self-Actualization', 'competency': {'code': 'SELF_MANAGEMENT', 'name': 'Self-Management'}, 'what_it_is': 'The continuous pursuit of personal growth and potential.'},
    {'id': 5, 'name': 'Independence', 'competency': {'code': 'SELF_MANAGEMENT', 'name': 'Self-Management'}, 'what_it_is': 'Being self-directed and free from emotional dependency.'},
    {'id': 6, 'name': 'Empathy', 'competency': {'code': 'INTERPERSONAL_MANAGEMENT', 'name': 'Interpersonal Management'}, 'what_it_is': 'Sensing and understanding the emotions of others.'},
    {'id': 7, 'name': 'Verbal Expression', 'competency': {'code': 'INTERPERSONAL_MANAGEMENT', 'name': 'Interpersonal Management'}, 'what_it_is': 'Clearly communicating your thoughts and feelings.'},
    {'id': 8, 'name': 'Non-verbal Communication', 'competency': {'code': 'INTERPERSONAL_MANAGEMENT', 'name': 'Interpersonal Management'}, 'what_it_is': 'Using body language and tone to reinforce your message.'},
    {'id': 9, 'name': 'Assertiveness', 'competency': {'code': 'INTERPERSONAL_MANAGEMENT', 'name': 'Interpersonal Management'}, 'what_it_is': 'Standing up for your rights without being aggressive.'},
    {'id': 10, 'name': 'Conflict Management', 'competency': {'code': 'INTERPERSONAL_MANAGEMENT', 'name': 'Interpersonal Management'}, 'what_it_is': 'Navigating disagreements toward a positive resolution.'},
    {'id': 11, 'name': 'Stress Tolerance', 'competency': {'code': 'STRESS_MANAGEMENT', 'name': 'Stress Management'}, 'what_it_is': 'Remaining calm and functional during difficult times.'},
    {'id': 12, 'name': 'Cognitive Flexibility', 'competency': {'code': 'STRESS_MANAGEMENT', 'name': 'Stress Management'}, 'what_it_is': 'Adjusting your emotions and thoughts to change.'},
    {'id': 13, 'name': 'Emotional Regulation', 'competency': {'code': 'STRESS_MANAGEMENT', 'name': 'Stress Management'}, 'what_it_is': 'Managing the intensity of your emotional responses.'},
    {'id': 14, 'name': 'Optimism', 'competency': {'code': 'STRESS_MANAGEMENT', 'name': 'Stress Management'}, 'what_it_is': 'Finding the bright side even in setbacks.'},
    {'id': 15, 'name': 'Social Resources', 'competency': {'code': 'STRESS_MANAGEMENT', 'name': 'Stress Management'}, 'what_it_is': 'Tapping into your support network for help.'},
    {'id': 16, 'name': 'Belief Influence', 'competency': {'code': 'SPIRIT_MANAGEMENT', 'name': 'Spirit Management'}, 'what_it_is': 'Using your core values to guide your behavior.'},
    {'id': 17, 'name': 'Clarity', 'competency': {'code': 'SPIRIT_MANAGEMENT', 'name': 'Spirit Management'}, 'what_it_is': 'Having a crystal-clear vision of your goals.'},
    {'id': 18, 'name': 'Energy Awareness', 'competency': {'code': 'SPIRIT_MANAGEMENT', 'name': 'Spirit Management'}, 'what_it_is': 'Tracking your physical and mental battery levels.'},
    {'id': 19, 'name': 'Community Building', 'competency': {'code': 'SPIRIT_MANAGEMENT', 'name': 'Spirit Management'}, 'what_it_is': 'Fostering a sense of belonging with others.'},
    {'id': 20, 'name': 'Meaning Making', 'competency': {'code': 'SPIRIT_MANAGEMENT', 'name': 'Spirit Management'}, 'what_it_is': 'Finding the why behind your daily tasks.'},
    {'id': 21, 'name': 'Planning', 'competency': {'code': 'EXECUTIVE_FUNCTION', 'name': 'Executive Function'}, 'what_it_is': 'Developing a roadmap for your objectives.'},
    {'id': 22, 'name': 'Prioritizing', 'competency': {'code': 'EXECUTIVE_FUNCTION', 'name': 'Executive Function'}, 'what_it_is': 'Sorting tasks by impact rather than urgency.'},
    {'id': 23, 'name': 'Motivation', 'competency': {'code': 'EXECUTIVE_FUNCTION', 'name': 'Executive Function'}, 'what_it_is': 'Generating the internal drive to get started.'},
    {'id': 24, 'name': 'Attention Span', 'competency': {'code': 'EXECUTIVE_FUNCTION', 'name': 'Executive Function'}, 'what_it_is': 'Sustaining focus on a single task without distraction.'},
    {'id': 25, 'name': 'Organization', 'competency': {'code': 'EXECUTIVE_FUNCTION', 'name': 'Executive Function'}, 'what_it_is': 'Structuring your digital and physical space for flow.'},
    {'id': 26, 'name': 'Processing Speed', 'competency': {'code': 'DECISION_MAKING', 'name': 'Decision Making'}, 'what_it_is': 'Rapidly analyzing data to reach a conclusion.'},
    {'id': 27, 'name': 'Impulse Control', 'competency': {'code': 'DECISION_MAKING', 'name': 'Decision Making'}, 'what_it_is': 'Resisting the urge to act without thinking.'},
    {'id': 28, 'name': 'Reality Testing', 'competency': {'code': 'DECISION_MAKING', 'name': 'Decision Making'}, 'what_it_is': 'Seeing things as they are, not as you fear or wish.'},
    {'id': 29, 'name': 'Abstraction', 'competency': {'code': 'DECISION_MAKING', 'name': 'Decision Making'}, 'what_it_is': 'Seeing patterns and big-picture concepts.'},
    {'id': 30, 'name': 'Problem Solving', 'competency': {'code': 'DECISION_MAKING', 'name': 'Decision Making'}, 'what_it_is': 'Finding effective, practical solutions to hurdles.'},
  ];

  @override
  void initState() {
    super.initState();
    _loadAbilities();
  }

  int _paceFromCode(String? code) {
    switch ((code ?? '').toUpperCase()) {
      case 'HIGH':
        return 3;
      case 'MEDIUM':
        return 2;
      case 'LOW':
        return 1;
      default:
        return 1;
    }
  }

  Future<void> _loadAbilities({String? overrideView}) async {
    final targetView = overrideView ?? _viewMode;
    setState(() => _isLoading = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final localPace = _paceFromCode(prefs.getString('selected_growth_plan'));
      Map<String, dynamic> data;
      if (widget.isOnboarding) {
        final sessionId = prefs.getString('onboarding_session_id');
        if (sessionId == null || sessionId.isEmpty || sessionId == 'mock_session_id') {
          _applyFallback(fallbackPace: localPace);
          return;
        }
        data = await _onboardingService.getOnboardingAbilities(sessionId, view: targetView);
      } else {
        data = await _journeyService.getAbilityOrder(view: targetView);
      }

      final rawList = (data['abilities'] as List<dynamic>? ?? []);
      final parsed = rawList.map((e) => Map<String, dynamic>.from(e as Map)).toList();
      final savedOrder = (data['ability_order'] as List<dynamic>? ?? [])
          .map((e) => (e as num).toInt())
          .toList();

      if (!mounted) return;
      final effectivePace = (data['abilities_per_day'] as num?)?.toInt() ?? localPace;
      setState(() {
        _viewMode = targetView;
        _abilitiesPerDay = effectivePace < 1 ? 1 : effectivePace;
        _abilities = parsed;
        if (overrideView == null && savedOrder.isNotEmpty) {
          final remaining = parsed
              .map((a) => (a['id'] as num).toInt())
              .where((id) => !savedOrder.contains(id));
          _orderedIds = [...savedOrder, ...remaining];
          _manualPicks = savedOrder.take(_abilitiesPerDay).toList();
        } else if (targetView == 'custom' && savedOrder.isNotEmpty) {
          final remaining = parsed
              .map((a) => (a['id'] as num).toInt())
              .where((id) => !savedOrder.contains(id));
          _orderedIds = [...savedOrder, ...remaining];
          _manualPicks = savedOrder.take(_abilitiesPerDay).toList();
        } else {
          _orderedIds = parsed.map((a) => (a['id'] as num).toInt()).toList();
          _manualPicks = [];
        }
        _isLoading = false;
      });
    } catch (_) {
      final prefs = await SharedPreferences.getInstance();
      final localPace = _paceFromCode(prefs.getString('selected_growth_plan'));
      _applyFallback(fallbackPace: localPace);
    }
  }

  void _applyFallback({int fallbackPace = 1}) {
    if (!mounted) return;
    setState(() {
      _abilitiesPerDay = fallbackPace;
      _abilities = _fallbackAbilities.map((e) => Map<String, dynamic>.from(e)).toList();
      _orderedIds = _abilities.map((a) => (a['id'] as num).toInt()).toList();
      _isLoading = false;
    });
  }

  List<Map<String, dynamic>> get _orderedAbilityObjects {
    final byId = {for (final a in _abilities) (a['id'] as num).toInt(): a};
    return _orderedIds.where(byId.containsKey).map((id) => byId[id]!).toList();
  }

  void _rebuildOrderWithManualPicks(List<int> nextPicks) {
    final baseSeq = _abilities.map((a) => (a['id'] as num).toInt()).toList();
    final remaining = [
      ..._orderedIds.where((id) => !nextPicks.contains(id)),
      ...baseSeq.where((id) => !nextPicks.contains(id) && !_orderedIds.contains(id)),
    ];
    _manualPicks = nextPicks;
    _orderedIds = [...nextPicks, ...remaining];
  }

  void _togglePickAbility(int abilityId) {
    setState(() {
      final nextPicks = List<int>.from(_manualPicks);
      if (nextPicks.contains(abilityId)) {
        nextPicks.remove(abilityId);
      } else {
        if (nextPicks.length >= _abilitiesPerDay && _abilitiesPerDay > 0) {
          // Keep queue size crisp for daily stack while preserving latest user intent.
          nextPicks.removeAt(0);
        }
        nextPicks.add(abilityId);
      }
      _rebuildOrderWithManualPicks(nextPicks);
    });
  }

  void _moveAbility(int abilityId, int delta) {
    final idx = _orderedIds.indexOf(abilityId);
    if (idx == -1) return;
    final nextIdx = (idx + delta).clamp(0, _orderedIds.length - 1);
    if (idx == nextIdx) return;
    setState(() {
      final item = _orderedIds.removeAt(idx);
      _orderedIds.insert(nextIdx, item);
      if (_manualPicks.contains(abilityId) && nextIdx >= _abilitiesPerDay) {
        _manualPicks.remove(abilityId);
      }
    });
  }

  void _promoteToTopStack(int abilityId) {
    setState(() {
      final nextPicks = [abilityId, ..._manualPicks.where((id) => id != abilityId)];
      if (nextPicks.length > _abilitiesPerDay && _abilitiesPerDay > 0) {
        nextPicks.removeRange(_abilitiesPerDay, nextPicks.length);
      }
      _rebuildOrderWithManualPicks(nextPicks);
    });
  }

  void _showAbilityPreviewSheet(Map<String, dynamic> ability) {
    final comp = (ability['competency'] as Map?) ?? {};
    final whatItIs = (ability['what_it_is'] ?? ability['description'] ?? '').toString();
    final whyItMatters = (ability['why_it_matters'] ?? '').toString();
    final whatYouWillDo = (ability['what_you_will_do'] ?? '').toString();

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              (comp['name'] ?? '').toString().toUpperCase(),
              style: const TextStyle(
                fontSize: 11,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                color: Color(0xFF249FA9),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              (ability['name'] ?? '').toString(),
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                color: Color(0xFF0B191D),
              ),
            ),
            if (whatItIs.isNotEmpty) ...[
              const SizedBox(height: 12),
              _previewBlock('What It Is', whatItIs),
            ],
            if (whyItMatters.isNotEmpty) ...[
              const SizedBox(height: 10),
              _previewBlock('Why It Matters', whyItMatters),
            ],
            if (whatYouWillDo.isNotEmpty) ...[
              const SizedBox(height: 10),
              _previewBlock("What You'll Do", whatYouWillDo),
            ],
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _promoteToTopStack((ability['id'] as num).toInt());
                  Navigator.of(ctx).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF073B4B),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Move to Priority #1',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _previewBlock(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: Color(0xFF073B4B),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13.5,
            fontFamily: 'Inter',
            color: Color(0xFF475569),
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Future<void> _saveAndContinue() async {
    if (_orderedIds.isEmpty) return;
    setState(() => _isSaving = true);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
        'selected_abilities_order',
        _orderedIds.map((e) => e.toString()).toList(),
      );
      if (widget.isOnboarding) {
        final sessionId = prefs.getString('onboarding_session_id');
        if (sessionId != null && sessionId.isNotEmpty && sessionId != 'mock_session_id') {
          await _onboardingService.saveOnboardingAbilities(sessionId, _orderedIds);
        }
        if (mounted) {
          if (widget.popOnSave && context.canPop()) {
            context.pop(true);
          } else {
            context.push('/time-preference');
          }
        }
      } else {
        await _journeyService.updateAbilityOrder(_orderedIds);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Your 30-ability priority stack has been updated!'),
              backgroundColor: Color(0xFF073B4B),
            ),
          );
          context.pop(true);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not save order: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderedAll = _orderedAbilityObjects;
    final topStack = orderedAll.take(_abilitiesPerDay).toList();
    final filteredList = _selectedCompetency == 'ALL'
        ? orderedAll
        : orderedAll
            .where((a) => (a['competency']?['code'] ?? '') == _selectedCompetency)
            .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAFC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0B191D)),
          onPressed: () {
            if (context.canPop()) context.pop();
          },
        ),
        title: const Text(
          'Prioritize Your 30 Abilities',
          style: TextStyle(
            color: Color(0xFF0B191D),
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Active Stack Summary Card - Sleek modern gradient
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF073B4B), Color(0xFF0F5064)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x18073B4B),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF94F990).withValues(alpha: 0.2),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: const Icon(
                                          Icons.auto_awesome,
                                          size: 13,
                                          color: Color(0xFF94F990),
                                        ),
                                      ),
                                      const SizedBox(width: 7),
                                      Flexible(
                                        child: Text(
                                          "TODAY'S FOCUS ($_abilitiesPerDay ${_abilitiesPerDay == 1 ? 'ABILITY' : 'ABILITIES'})",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Color(0xFF94F990),
                                            fontSize: 11,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 0.6,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (_manualPicks.isNotEmpty) ...[
                                  const SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: () => _loadAbilities(overrideView: 'recommended'),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(alpha: 0.15),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Text(
                                        'Reset to AI',
                                        style: TextStyle(
                                          color: Color(0xFF7DD3FC),
                                          fontSize: 11,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: topStack.asMap().entries.map((entry) {
                                final itemId = (entry.value['id'] as num).toInt();
                                final isManual = _manualPicks.contains(itemId);
                                return GestureDetector(
                                  onTap: isManual ? () => _togglePickAbility(itemId) : null,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: isManual
                                          ? const Color(0xFF22C55E).withValues(alpha: 0.25)
                                          : Colors.white.withValues(alpha: 0.14),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: isManual
                                            ? const Color(0xFF86EFAC)
                                            : Colors.white.withValues(alpha: 0.25),
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          '#${entry.key + 1} ${entry.value['name']}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        if (isManual) ...[
                                          const SizedBox(width: 4),
                                          const Icon(Icons.close, size: 13, color: Colors.white),
                                        ],
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              _manualPicks.isEmpty
                                  ? 'Ranked by AI. Tap "+ Pick" below to put yours first.'
                                  : 'Picked ${_manualPicks.length}/$_abilitiesPerDay custom start — remaining slots keep AI priority.',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.75),
                                fontSize: 11,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Order Source Mode Switcher - Modern Segmented Control
                      Container(
                        height: 38,
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE2E8F0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            _modeChip('recommended', 'Recommended'),
                            _modeChip('chosen', 'Guided Journey'),
                            _modeChip('custom', 'My Order'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Competency filter strip - Clean category pills
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _filterChip('ALL', 'All 30'),
                            _filterChip('SELF_MANAGEMENT', 'Self'),
                            _filterChip('INTERPERSONAL_MANAGEMENT', 'Interpersonal'),
                            _filterChip('STRESS_MANAGEMENT', 'Stress'),
                            _filterChip('SPIRIT_MANAGEMENT', 'Spirit'),
                            _filterChip('EXECUTIVE_FUNCTION', 'Executive'),
                            _filterChip('DECISION_MAKING', 'Decision'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 2, 20, 80),
                    itemCount: filteredList.length,
                    itemBuilder: (ctx, index) {
                      final ability = filteredList[index];
                      final aid = (ability['id'] as num).toInt();
                      final globalRank = _orderedIds.indexOf(aid) + 1;
                      final isInTodayStack = globalRank <= _abilitiesPerDay;
                      final isManualPicked = _manualPicks.contains(aid);
                      final recRank = (ability['recommended_rank'] as num?)?.toInt();
                      final isAiTop = recRank != null && recRank <= _abilitiesPerDay;
                      final compName = (ability['competency']?['name'] ?? '').toString();
                      final compCode = (ability['competency']?['code'] ?? '').toString();
                      final compColor = _competencyColor(compCode);

                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: isInTodayStack ? const Color(0xFFF0FDF4) : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isInTodayStack
                                ? const Color(0xFF22C55E).withValues(alpha: 0.7)
                                : const Color(0xFFE2E8F0),
                            width: isInTodayStack ? 1.5 : 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: isInTodayStack
                                  ? const Color(0xFF22C55E).withValues(alpha: 0.08)
                                  : const Color(0x06000000),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () => _showAbilityPreviewSheet(ability),
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Top row: Rank badge + Competency Tag + Status Badges
                                  Row(
                                    children: [
                                      // Rank Badge
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                                        decoration: BoxDecoration(
                                          color: isInTodayStack
                                              ? const Color(0xFF073B4B)
                                              : const Color(0xFFF1F5F9),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          '#$globalRank',
                                          style: TextStyle(
                                            color: isInTodayStack ? Colors.white : const Color(0xFF475569),
                                            fontSize: 11,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 6),

                                      // Competency category tag
                                      Flexible(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                                          decoration: BoxDecoration(
                                            color: compColor.withValues(alpha: 0.12),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: 5,
                                                height: 5,
                                                decoration: BoxDecoration(
                                                  color: compColor,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              Flexible(
                                                child: Text(
                                                  compName,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: compColor,
                                                    fontSize: 10.5,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      const SizedBox(width: 6),

                                      // Status Badges
                                      if (isAiTop && !isManualPicked) ...[
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFE0F2FE),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: const Text(
                                            'AI Pick',
                                            style: TextStyle(
                                              color: Color(0xFF0369A1),
                                              fontSize: 10,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                      ],
                                      if (isInTodayStack)
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFDCFCE7),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            isManualPicked ? 'Picked' : 'Today',
                                            style: const TextStyle(
                                              color: Color(0xFF15803D),
                                              fontSize: 10,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),

                                  const SizedBox(height: 10),

                                  // Middle: Ability Name
                                  Text(
                                    (ability['name'] ?? '').toString(),
                                    style: const TextStyle(
                                      color: Color(0xFF0B191D),
                                      fontSize: 15.5,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      height: 1.25,
                                    ),
                                  ),
                                  const SizedBox(height: 4),

                                  // Description
                                  Text(
                                    (ability['what_it_is'] ?? '').toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Color(0xFF64748B),
                                      fontSize: 12.5,
                                      fontFamily: 'Inter',
                                      height: 1.35,
                                    ),
                                  ),

                                  const SizedBox(height: 12),

                                  // Bottom Actions Row: Tap hint + Pick Button + Reorder Stepper
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.info_outline,
                                        size: 14,
                                        color: Color(0xFF94A3B8),
                                      ),
                                      const SizedBox(width: 3),
                                      const Text(
                                        'Details',
                                        style: TextStyle(
                                          color: Color(0xFF94A3B8),
                                          fontSize: 11,
                                          fontFamily: 'Inter',
                                        ),
                                      ),

                                      const Spacer(),

                                      // Pick / Remove Button
                                      InkWell(
                                        borderRadius: BorderRadius.circular(8),
                                        onTap: () => _togglePickAbility(aid),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                                          decoration: BoxDecoration(
                                            color: isManualPicked
                                                ? const Color(0xFF073B4B)
                                                : const Color(0xFFF1F5F9),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            isManualPicked ? '✓ Picked' : '+ Pick',
                                            style: TextStyle(
                                              color: isManualPicked
                                                  ? Colors.white
                                                  : const Color(0xFF073B4B),
                                              fontSize: 11.5,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 6),

                                      // Reorder stepper buttons
                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF8FAFC),
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(color: const Color(0xFFE2E8F0)),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            InkWell(
                                              borderRadius: const BorderRadius.horizontal(left: Radius.circular(7)),
                                              onTap: globalRank > 1 ? () => _moveAbility(aid, -1) : null,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                                                child: Icon(
                                                  Icons.arrow_upward,
                                                  size: 14,
                                                  color: globalRank > 1
                                                      ? const Color(0xFF073B4B)
                                                      : const Color(0xFFCBD5E1),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 1,
                                              height: 14,
                                              color: const Color(0xFFE2E8F0),
                                            ),
                                            InkWell(
                                              borderRadius: const BorderRadius.horizontal(right: Radius.circular(7)),
                                              onTap: globalRank < _orderedIds.length ? () => _moveAbility(aid, 1) : null,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                                                child: Icon(
                                                  Icons.arrow_downward,
                                                  size: 14,
                                                  color: globalRank < _orderedIds.length
                                                      ? const Color(0xFF073B4B)
                                                      : const Color(0xFFCBD5E1),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Floating Bottom Action Bar with soft gradient overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFFF8FAFC).withValues(alpha: 0.0),
                        const Color(0xFFF8FAFC).withValues(alpha: 0.95),
                        const Color(0xFFF8FAFC),
                      ],
                      stops: const [0.0, 0.3, 1.0],
                    ),
                  ),
                  child: SafeArea(
                    top: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isSaving ? null : _saveAndContinue,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF073B4B),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            elevation: 2,
                            shadowColor: const Color(0x30073B4B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: _isSaving
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                )
                              : Text(
                                  widget.isOnboarding
                                      ? 'Save Stack & Continue'
                                      : 'Save Priority Order',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Color _competencyColor(String? code) {
    switch ((code ?? '').toUpperCase()) {
      case 'SELF_MANAGEMENT':
        return const Color(0xFF43BDC7);
      case 'INTERPERSONAL_MANAGEMENT':
        return const Color(0xFF3FA9E2);
      case 'STRESS_MANAGEMENT':
        return const Color(0xFF33B87B);
      case 'SPIRIT_MANAGEMENT':
        return const Color(0xFFF7931E);
      case 'EXECUTIVE_FUNCTION':
        return const Color(0xFF5C6AC4);
      case 'DECISION_MAKING':
        return const Color(0xFF4776E6);
      default:
        return const Color(0xFF073B4B);
    }
  }

  Widget _modeChip(String mode, String label) {
    final active = _viewMode == mode;
    return Expanded(
      child: GestureDetector(
        onTap: () => _loadAbilities(overrideView: mode),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            color: active ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: active
                ? const [
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 4,
                      offset: Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: active ? const Color(0xFF073B4B) : const Color(0xFF64748B),
              fontSize: 12,
              fontFamily: 'Inter',
              fontWeight: active ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _filterChip(String code, String label) {
    final active = _selectedCompetency == code;
    final color = code == 'ALL' ? const Color(0xFF073B4B) : _competencyColor(code);

    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => setState(() => _selectedCompetency = code),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: active ? const Color(0xFF073B4B) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: active ? const Color(0xFF073B4B) : const Color(0xFFE2E8F0),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (code != 'ALL') ...[
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 5),
              ],
              Text(
                label,
                style: TextStyle(
                  color: active ? Colors.white : const Color(0xFF475569),
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

