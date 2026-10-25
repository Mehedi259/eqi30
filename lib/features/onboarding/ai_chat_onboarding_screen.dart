import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/services/onboarding_service.dart';
import '../../core/services/ai_service.dart';
import 'models/assessment_data.dart';

class AiChatOnboardingScreen extends StatefulWidget {
  const AiChatOnboardingScreen({super.key});

  @override
  State<AiChatOnboardingScreen> createState() => _AiChatOnboardingScreenState();
}

class _AiChatOnboardingScreenState extends State<AiChatOnboardingScreen>
    with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  double _sliderValue = 7.0;
  List<Map<String, dynamic>> _messages = [];
  bool _showQuickReplies = true;
  bool _isAnalyzing = false;

  int _currentQuestionIndex = 0;
  final Map<int, int> _answers = {};

  late AnimationController _headerController;
  late AnimationController _avatarController;
  late AnimationController _buttonController;

  late Animation<double> _headerFadeAnimation;
  late Animation<double> _avatarPulseAnimation;
  late Animation<Offset> _buttonSlideAnimation;
  late Animation<double> _buttonFadeAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeChat();
    _startAnimations();
  }

  void _initializeAnimations() {
    // Header animation
    _headerController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _headerFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _headerController, curve: Curves.easeOut),
    );

    // Avatar pulse animation (continuous)
    _avatarController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _avatarPulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _avatarController, curve: Curves.easeInOut),
    );

    // Button animation
    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _buttonSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(parent: _buttonController, curve: Curves.easeOut),
        );

    _buttonFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _buttonController, curve: Curves.easeIn));
  }

  void _startAnimations() {
    _headerController.forward();
    _avatarController.repeat(reverse: true);
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _buttonController.forward();
    });
  }

  String _formatCurrentTime() {
    final now = TimeOfDay.now();
    return '${now.hour}:${now.minute.toString().padLeft(2, '0')}';
  }

  void _initializeChat() {
    _messages = [];
    _currentQuestionIndex = 0;
    _answers.clear();

    _messages.add({
      'type': 'bot',
      'message':
          "Hello! I am your AI Emotional Intelligence Guide 🌟\n\nI will guide you through the official EQi-30 assessment — 103 statements across 30 vital emotional abilities and 6 competencies.\n\nFor each question, rate how accurately it fits you from 1 (Never / Strongly Disagree) to 10 (Always / Strongly Agree), or feel free to chat with me at any point!",
      'time': _formatCurrentTime(),
    });

    _sendQuestionToChat(0);
  }

  void _sendQuestionToChat(int index) {
    if (index >= AssessmentData.questions.length) {
      _messages.add({
        'type': 'bot',
        'message':
            "🎉 Fantastic job! You have answered all 103 assessment questions!\n\nTap 'CONTINUE & VIEW THE RESULT' below to explore your 30-ability emotional intelligence breakdown and personalized growth roadmap.",
        'time': _formatCurrentTime(),
      });
      setState(() {});
      _scrollToBottom();
      return;
    }

    final q = AssessmentData.questions[index];
    final isNewSection = index == 0 ||
        AssessmentData.questions[index - 1].competencyKey != q.competencyKey;

    String sectionIntro = "";
    if (isNewSection && index > 0) {
      final prevName = AssessmentData.questions[index - 1].competencyName;
      sectionIntro =
          "🌟 Great job completing $prevName!\n\nNow, let's explore **${q.competencyName}**:\n\n";
    }

    _messages.add({
      'type': 'bot',
      'isQuestion': true,
      'questionId': q.id,
      'questionIndex': index,
      'competencyName': q.competencyName,
      'abilityName': q.abilityName,
      'questionText': q.text,
      'message':
          "$sectionIntro**Question ${index + 1} of 103** • ${q.abilityName}\n\n\"${q.text}\"",
      'hasSlider': true,
      'time': _formatCurrentTime(),
    });

    setState(() {});
    _scrollToBottom();
  }

  void _onRateQuestion(int questionId, int score) {
    _answers[questionId] = score;

    _addMessage('user', "Rating: $score / 10");

    if (_currentQuestionIndex < AssessmentData.questions.length &&
        AssessmentData.questions[_currentQuestionIndex].id == questionId) {
      _currentQuestionIndex++;

      setState(() {
        _sliderValue = 7.0;
      });

      Future.delayed(const Duration(milliseconds: 250), () {
        if (!mounted) return;
        _sendQuestionToChat(_currentQuestionIndex);
      });
    }
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    _addMessage('user', text);
    _messageController.clear();

    // Check if the user typed a plain rating like "8" or "8/10"
    final parsedRating = int.tryParse(text.replaceAll('/10', '').trim());
    if (parsedRating != null &&
        parsedRating >= 1 &&
        parsedRating <= 10 &&
        _currentQuestionIndex < AssessmentData.questions.length) {
      final q = AssessmentData.questions[_currentQuestionIndex];
      _onRateQuestion(q.id, parsedRating);
      return;
    }

    // Otherwise, conversational coaching response from AI
    await _fetchAiResponse(text);
  }

  Future<void> _sendQuickReply(String message) async {
    if (message == 'Show my results') {
      await _submitAndNavigateToResults();
      return;
    }

    if (message == 'What\'s next?') {
      if (_currentQuestionIndex < AssessmentData.questions.length) {
        final q = AssessmentData.questions[_currentQuestionIndex];
        _addMessage('user', "What's next?");
        _addMessage('bot',
            "We are on Question ${_currentQuestionIndex + 1} of 103 evaluating **${q.abilityName}** (${q.competencyName}).\n\nRate on a scale of 1 to 10 whenever you are ready!");
      }
      return;
    }

    _addMessage('user', message);
    setState(() {
      _showQuickReplies = false;
    });

    await _fetchAiResponse(message);
  }

  void _addMessage(String type, String message, {bool hasSlider = false}) {
    setState(() {
      _messages.add({
        'type': type,
        'message': message,
        'time': _formatCurrentTime(),
        if (hasSlider) 'hasSlider': true,
      });
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _fetchAiResponse(String userMessage) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final sessionId = prefs.getString('onboarding_session_id');

      final history = _messages
          .where((m) => m['type'] != null && m['message'] != null)
          .map((m) => {
                'role': m['type'] == 'bot' ? 'assistant' : 'user',
                'content': m['message'] as String,
              })
          .toList();

      if (history.isNotEmpty && history.last['role'] == 'user') {
        history.removeLast();
      }

      final response = await AiService().respondToChat(
        userMessage,
        sessionId: sessionId,
        history: history,
      );

      if (response.containsKey('reply')) {
        String reply = response['reply'];
        _addMessage('bot', reply);
      } else {
        _addMessage('bot', 'Thank you for sharing. Whenever you are ready, please select your rating for the current question!');
      }
    } catch (e) {
      debugPrint('Chat API Error: $e');
      _addMessage('bot', 'I hear you. Feel free to rate the current question (1-10) whenever you are ready to continue.');
    }
  }

  Future<void> _submitAndNavigateToResults() async {
    setState(() {
      _isAnalyzing = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      String? sessionId = prefs.getString('onboarding_session_id');
      if (sessionId == null) {
        final sessionRes = await OnboardingService().createSession();
        sessionId = sessionRes['session_uuid'];
        if (sessionId != null) {
          await prefs.setString('onboarding_session_id', sessionId);
        }
      }

      // Calculate scores using official scoring algorithm
      final results = AssessmentData.calculateScores(_answers);

      // Save locally
      await prefs.setString('eqi30_assessment_answers', jsonEncode(
        _answers.map((k, v) => MapEntry(k.toString(), v)),
      ));
      await prefs.setString('eqi30_assessment_results', jsonEncode(results));

      // Submit to backend
      if (sessionId != null) {
        await OnboardingService().submitAssessment(sessionId, {
          'results': results,
        });
      }

      if (mounted) {
        context.go('/result-onboarding');
      }
    } catch (e) {
      debugPrint("Error finalizing assessment: $e");
      if (mounted) {
        context.go('/result-onboarding');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isAnalyzing = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _headerController.dispose();
    _avatarController.dispose();
    _buttonController.dispose();
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
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/onboarding');
            }
          },
        ),
        title: const Text(
          'Chat With AI',
          style: TextStyle(
            color: Color(0xFF0B191D),
            fontSize: 18,
            fontFamily: 'Archivo',
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  // Header Section
                  AnimatedBuilder(
                    animation: _headerFadeAnimation,
                    builder: (context, child) {
                      return FadeTransition(
                        opacity: _headerFadeAnimation,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 26,
                            vertical: 8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'AI ASSESSMENT',
                                    style: TextStyle(
                                      color: Color(0xFF50A8C0),
                                      fontSize: 11,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.10,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE0F2F7),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      '${_answers.length} / 103 Answered',
                                      style: const TextStyle(
                                        color: Color(0xFF073B4B),
                                        fontSize: 11,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Let\'s find your path.',
                                style: TextStyle(
                                  color: Color(0xFF1A2B4A),
                                  fontSize: 24,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Based on your answers, here are your highest-impact starting points.',
                                style: TextStyle(
                                  color: Color(0xFF8A96A8),
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 12),
                              // Animated Bot Avatar with pulse
                              Center(
                                child: AnimatedBuilder(
                                  animation: _avatarPulseAnimation,
                                  builder: (context, child) {
                                    return Transform.scale(
                                      scale: _avatarPulseAnimation.value,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          // Animated rings
                                          Container(
                                            width: 80,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.white.withValues(
                                                  alpha: 0.44,
                                                ),
                                                width: 0.5,
                                              ),
                                            ),
                                          ),
                                          // Bot image
                                          Container(
                                            width: 60,
                                            height: 60,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  'assets/images/guide maskot.png',
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  // Chat Messages
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 26,
                      vertical: 16,
                    ),
                    child: Column(
                      children: _messages.map((message) {
                        if (message['type'] == 'bot') {
                          if (message['hasSlider'] == true) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: _buildBotMessageWithSlider(
                                message,
                                message['time'],
                              ),
                            );
                          }
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _buildBotMessage(
                              message['message'],
                              message['time'],
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _buildUserMessage(
                              message['message'],
                              message['time'],
                            ),
                          );
                        }
                      }).toList(),
                    ),
                  ),

                  // Quick Reply Chips
                  if (_showQuickReplies)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 26,
                        vertical: 4,
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildQuickReplyChip('Tell me more'),
                            const SizedBox(width: 8),
                            _buildQuickReplyChip('What\'s next?'),
                            const SizedBox(width: 8),
                            _buildQuickReplyChip('Show my results'),
                            const SizedBox(width: 8),
                            _buildQuickReplyChip('Ask another question'),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Message Input
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: const Color(0xFFE2E8F0),
                        width: 1,
                      ),
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type your message or rating (1-10)...',
                        hintStyle: TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      maxLines: null,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFF095A70),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF095A70).withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Animated Continue Button
          AnimatedBuilder(
            animation: _buttonFadeAnimation,
            builder: (context, child) {
              return FadeTransition(
                opacity: _buttonFadeAnimation,
                child: SlideTransition(
                  position: _buttonSlideAnimation,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(26, 0, 26, 16),
                    color: Colors.white,
                    child: SafeArea(
                      top: false,
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isAnalyzing
                              ? null
                              : () => _submitAndNavigateToResults(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF073B4B),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (_isAnalyzing)
                                const Padding(
                                  padding: EdgeInsets.only(right: 12.0),
                                  child: SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  ),
                                ),
                              Text(
                                _isAnalyzing
                                    ? 'ANALYZING PROFILE...'
                                    : 'CONTINUE & VIEW THE RESULT',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              if (!_isAnalyzing) ...[
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.arrow_forward,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBotMessage(String message, String time) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/guide maskot.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0x471284A7),
                      Color(0x33C9F2FF),
                      Color(0x471385A8),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Color(0xFF1E3A42),
                    fontSize: 13,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                time,
                style: const TextStyle(
                  color: Color(0xFF073B4B),
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBotMessageWithSlider(
      Map<String, dynamic> messageData, String time) {
    final String message = messageData['message'] ?? '';
    final int? qId = messageData['questionId'];
    final bool isAnswered = qId != null && _answers.containsKey(qId);
    final int? answeredScore = qId != null ? _answers[qId] : null;
    final bool isLatestQuestion = qId != null &&
        _currentQuestionIndex < AssessmentData.questions.length &&
        AssessmentData.questions[_currentQuestionIndex].id == qId;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/images/guide maskot.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message,
                      style: const TextStyle(
                        color: Color(0xFF1E3A42),
                        fontSize: 13,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                    const SizedBox(height: 12),

                    if (isAnswered) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F7F8),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFF43BDC7)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.check_circle_rounded,
                                size: 16, color: Color(0xFF249FA9)),
                            const SizedBox(width: 6),
                            Text(
                              "Recorded: $answeredScore / 10",
                              style: const TextStyle(
                                color: Color(0xFF0F3B4A),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ] else if (isLatestQuestion || qId == null) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: const Color(0xFFE2E8F0), width: 1),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _sliderValue.toInt().toString(),
                                  style: const TextStyle(
                                    color: Color(0xFF0F1E3C),
                                    fontSize: 24,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const Text(
                                  ' / 10',
                                  style: TextStyle(
                                    color: Color(0xFF64748B),
                                    fontSize: 14,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // Interactive Slider
                            SliderTheme(
                              data: SliderThemeData(
                                trackHeight: 6,
                                thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 10,
                                ),
                                overlayShape: const RoundSliderOverlayShape(
                                  overlayRadius: 20,
                                ),
                                activeTrackColor: const Color(0xFF249FA9),
                                inactiveTrackColor: const Color(0xFFCBD5E1),
                                thumbColor: const Color(0xFF0F3B4A),
                                overlayColor: const Color(0xFF249FA9)
                                    .withValues(alpha: 0.2),
                              ),
                              child: Slider(
                                value: _sliderValue,
                                min: 1,
                                max: 10,
                                divisions: 9,
                                onChanged: (value) {
                                  setState(() {
                                    _sliderValue = value;
                                  });
                                },
                              ),
                            ),

                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '1 - Never',
                                  style: TextStyle(
                                    color: Color(0xFF64748B),
                                    fontSize: 11,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '10 - Always',
                                  style: TextStyle(
                                    color: Color(0xFF64748B),
                                    fontSize: 11,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // Quick tap pills 1..10
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(10, (idx) {
                                  final num = idx + 1;
                                  final isSelected =
                                      _sliderValue.toInt() == num;
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _sliderValue = num.toDouble();
                                      });
                                      if (qId != null) {
                                        _onRateQuestion(qId, num);
                                      }
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 3),
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? const Color(0xFF0F3B4A)
                                            : Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: isSelected
                                              ? const Color(0xFF0F3B4A)
                                              : const Color(0xFFCBD5E1),
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '$num',
                                          style: TextStyle(
                                            color: isSelected
                                                ? Colors.white
                                                : const Color(0xFF1E3A42),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Submit Rating Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (qId != null) {
                                    _onRateQuestion(qId, _sliderValue.toInt());
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF249FA9),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  "Confirm Rating (${_sliderValue.toInt()} / 10)",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Text(
                time,
                style: const TextStyle(
                  color: Color(0xFF073B4B),
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUserMessage(String message, String time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Color(0xFF095A70),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Color(0xFFFFF5F5),
                    fontSize: 13,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.38,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                time,
                style: const TextStyle(
                  color: Color(0xFF073B4B),
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickReplyChip(String label) {
    return GestureDetector(
      onTap: () => _sendQuickReply(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFE0F2F7),
          border: Border.all(color: const Color(0xFF95D5E6), width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xFF073B4B),
            fontSize: 13,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
