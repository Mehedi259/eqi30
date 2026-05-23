import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [
    ChatMessage(
      text:
          'Hi Sarah! 👋 I\'m here to support your practice. What\'s on your mind today?',
      isUser: false,
      timestamp: '10:02 AM',
    ),
    ChatMessage(
      text: 'I\'m having trouble planning this week.',
      isUser: true,
      timestamp: '10:02 AM',
    ),
    ChatMessage(
      text:
          'I hear you — planning stress is really common when we\'re focused on high-performance goals. Let\'s break it down into manageable emotional chunks.',
      isUser: false,
      timestamp: '10:02 AM',
      showActionButtons: true,
    ),
  ];

  final List<String> _quickReplies = [
    'Help me with today\'s exercise',
    'I feel stressed right now',
    'Explain emotional regulation',
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(text: text, isUser: true, timestamp: '10:02 AM'),
      );
    });
    _messageController.clear();

    // Simulate AI response
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        _messages.add(
          ChatMessage(
            text: 'That\'s a great question! Let me help you with that.',
            isUser: false,
            timestamp: '10:02 AM',
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
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
                  const Text(
                    'Chat With AI',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF0B191D),
                      fontSize: 18,
                      fontFamily: 'Archivo',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 24),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Messages
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _buildMessageBubble(_messages[index]);
                },
              ),
            ),

            // Quick Reply Buttons
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _quickReplies.map((reply) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: _buildQuickReplyButton(reply),
                    );
                  }).toList(),
                ),
              ),
            ),

            // Input Field
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: const Color(0xFFE2E8F0),
                          width: 1,
                        ),
                      ),
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: 'Write your message...',
                          hintStyle: TextStyle(
                            color: Color(0xFF94A3B8),
                            fontSize: 14,
                            fontFamily: 'Inter',
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: const TextStyle(
                          color: Color(0xFF0B191D),
                          fontSize: 14,
                          fontFamily: 'Inter',
                        ),
                        onSubmitted: _sendMessage,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () => _sendMessage(_messageController.text),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: Color(0xFF095A70),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        mainAxisAlignment: message.isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF095A70),
                borderRadius: BorderRadius.circular(1000),
                image: const DecorationImage(
                  image: AssetImage('assets/images/botImage.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: message.isUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: message.isUser
                        ? null
                        : const LinearGradient(
                            begin: Alignment(1.00, 0.56),
                            end: Alignment(0.00, 0.56),
                            colors: [
                              Color(0x471284A7),
                              Color(0x33C9F2FF),
                              Color(0x33C9F2FF),
                              Color(0x33C9F2FF),
                              Color(0x471385A8),
                            ],
                          ),
                    color: message.isUser ? const Color(0xFF095A70) : null,
                    borderRadius: BorderRadius.only(
                      topLeft: message.isUser
                          ? const Radius.circular(12)
                          : Radius.zero,
                      topRight: message.isUser
                          ? Radius.zero
                          : const Radius.circular(12),
                      bottomLeft: const Radius.circular(12),
                      bottomRight: const Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.text,
                        style: TextStyle(
                          color: message.isUser
                              ? const Color(0xFFFFF5F5)
                              : const Color(0xFF383838),
                          fontSize: message.isUser ? 13 : 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),
                      if (message.showActionButtons) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFA3FFCC),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Planning & Prioritizing',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF0B191D),
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Flexible(
                                child: Text(
                                  'Do a 5-min Planning exercise now',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF095A70),
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.arrow_forward,
                                size: 14,
                                color: Color(0xFF095A70),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  message.timestamp,
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
          if (message.isUser) ...[
            const SizedBox(width: 12),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: const DecorationImage(
                  image: AssetImage('assets/images/profile image.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQuickReplyButton(String text) {
    return GestureDetector(
      onTap: () => _sendMessage(text),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0x99D5E2E6),
          border: Border.all(width: 1, color: const Color(0x26A8D3DF)),
          borderRadius: BorderRadius.circular(9999),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF073B4B),
            fontSize: 14,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final String timestamp;
  final bool showActionButtons;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.showActionButtons = false,
  });
}
