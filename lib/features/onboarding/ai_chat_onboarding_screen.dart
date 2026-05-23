import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AiChatOnboardingScreen extends StatefulWidget {
  const AiChatOnboardingScreen({super.key});

  @override
  State<AiChatOnboardingScreen> createState() => _AiChatOnboardingScreenState();
}

class _AiChatOnboardingScreenState extends State<AiChatOnboardingScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  double _sliderValue = 6.0;
  List<Map<String, dynamic>> _messages = [];
  bool _showQuickReplies = true;

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  void _initializeChat() {
    _messages = [
      {
        'type': 'bot',
        'message':
            'Hi Sarah! I\'m your EQ guide. I\'ll ask you a few questions to understand where you are right now. There are no right or wrong answers. 😊',
        'time': '10:02 AM',
      },
      {
        'type': 'bot',
        'message':
            'On a scale of 1–10, how well do you manage your emotions when things get stressful at work?',
        'time': '10:02 AM',
        'hasSlider': true,
      },
      {
        'type': 'user',
        'message':
            'I\'d say about a 6. I know what I feel but sometimes I react too fast.',
        'time': '10:02 AM',
      },
      {
        'type': 'bot',
        'message':
            'That\'s really good self-awareness! Noticing that you react quickly is already a huge first step. 💡\n\nBased on what you\'ve shared so far, Emotional Regulation might be a great starting point for you.',
        'time': '10:02 AM',
      },
      {'type': 'user', 'message': 'Tell me more', 'time': '10:02 AM'},
      {
        'type': 'bot',
        'message':
            'Thanks for sharing that. Let me analyze your responses and suggest the best starting point for your EQ journey... 🔍',
        'time': '10:02 AM',
      },
    ];
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        'type': 'user',
        'message': _messageController.text.trim(),
        'time': '10:02 AM',
      });
      _messageController.clear();
    });

    // Scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    // Simulate bot response
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _messages.add({
          'type': 'bot',
          'message': 'Thank you for sharing! Let me help you with that.',
          'time': '10:02 AM',
        });
      });

      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    });
  }

  void _sendQuickReply(String message) {
    setState(() {
      _messages.add({'type': 'user', 'message': message, 'time': '10:02 AM'});
      _showQuickReplies = false;
    });

    // Scroll to bottom
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

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
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
              color: Colors.black.withOpacity(0.10),
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
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 26,
                      vertical: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        // Bot Avatar with animation rings
                        Center(
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
                                    color: Colors.white.withOpacity(0.44),
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              // Bot image
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: const DecorationImage(
                                    image: AssetImage(
                                      'assets/images/botImage.png',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                                message['message'],
                                _sliderValue.toInt(),
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
                  color: Colors.black.withOpacity(0.05),
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
                        hintText: 'Type your message...',
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
                          color: const Color(0xFF095A70).withOpacity(0.3),
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

          // Continue Button
          Container(
            padding: const EdgeInsets.fromLTRB(26, 0, 26, 8),
            color: Colors.white,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to results screen
                  context.go('/result-onboarding');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF073B4B),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'CONTINUE & VIEW THE RESULT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, size: 18, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBotMessage(String message, String time) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bot avatar with animation rings
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: const DecorationImage(
                  image: AssetImage('assets/images/botImage.png'),
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
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0x471284A7),
                      Color(0x33C9F2FF),
                      Color(0x471385A8),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Color(0xFF383838),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              const SizedBox(height: 8),
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

  Widget _buildBotMessageWithSlider(String message, int value, String time) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bot avatar
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/images/botImage.png'),
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
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0x471284A7),
                      Color(0x33C9F2FF),
                      Color(0x471385A8),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message,
                      style: const TextStyle(
                        color: Color(0xFF383838),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.30),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Text(
                            _sliderValue.toInt().toString(),
                            style: const TextStyle(
                              color: Color(0xFF0F1E3C),
                              fontSize: 22,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SliderTheme(
                            data: SliderThemeData(
                              trackHeight: 4,
                              thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 8,
                              ),
                              overlayShape: const RoundSliderOverlayShape(
                                overlayRadius: 16,
                              ),
                              activeTrackColor: const Color(0xFF095A70),
                              inactiveTrackColor: const Color(0xFFCCCCCC),
                              thumbColor: const Color(0xFF0F1E3C),
                              overlayColor: const Color(
                                0xFF095A70,
                              ).withOpacity(0.2),
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
                          const SizedBox(height: 4),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '1-Not at all',
                                style: TextStyle(
                                  color: Color(0xFF637275),
                                  fontSize: 10,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                '10-very well',
                                style: TextStyle(
                                  color: Color(0xFF637275),
                                  fontSize: 10,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
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
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
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
              const SizedBox(height: 8),
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
        const SizedBox(width: 12),
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/images/profile image.png'),
              fit: BoxFit.cover,
            ),
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
