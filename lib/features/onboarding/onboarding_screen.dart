import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<String> messages = [
    "The stuff nobody taught you",
    "How to stay calm when it counts",
    "How to say what you mean",
    "How to make decisions under pressure",
    "Built on holistic neuroscientific techniques, this app helps you master these skills in just 5 minutes a day."
  ];

  int _activeMessages = 0;
  bool _showFinalElements = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _activeMessages = 1;
        });
      }
    });
  }

  void _onMessageComplete(int index) {
    if (index == _activeMessages - 1) {
      if (_activeMessages < messages.length) {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) {
            setState(() {
              _activeMessages++;
            });
          }
        });
      } else {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            setState(() {
              _showFinalElements = true;
            });
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background decorative shapes - closer to the design
          Positioned(
            top: -100,
            right: -80,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                color: const Color(0xFFE5EEE9).withOpacity(0.7),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -150,
            left: -100,
            child: Container(
              width: 450,
              height: 450,
              decoration: BoxDecoration(
                color: const Color(0xFFE5EEE9).withOpacity(0.6),
                shape: BoxShape.circle,
              ),
            ),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color(0xFF4A6F75),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                    ),
                    onPressed: () {
                      if (context.canPop()) {
                        context.pop();
                      }
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    itemCount: _activeMessages,
                    itemBuilder: (context, index) {
                      return MessageItem(
                        text: messages[index],
                        isLast: index == 4,
                        showLine: index > 0,
                        onComplete: () => _onMessageComplete(index),
                      );
                    },
                  ),
                ),
                // Bottom section (guide + button)
                AnimatedOpacity(
                  opacity: _showFinalElements ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 800),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 16),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 3),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  )
                                ],
                              ),
                              child: const CircleAvatar(
                                radius: 24,
                                backgroundColor: Colors.white,
                                backgroundImage: AssetImage('assets/images/guide maskot.png'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFD7F0F5), Color(0xFFE9F7F9)],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.04),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  )
                                ],
                              ),
                              child: Text(
                                "Hi, I'm Ember I'll guide you.",
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF4A6F75),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              context.go('/ai-chat-onboarding');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0F3B4A),
                              padding: const EdgeInsets.symmetric(vertical: 22),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Try a quick Exercise",
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Icon(Icons.arrow_forward, color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Side mascot - properly positioned relative to the screen to match design
          Positioned(
            right: 10, // Moved to the left to ensure it's fully visible
            bottom: size.height * 0.22, // Place it just above the bottom container
            child: IgnorePointer(
              child: AnimatedOpacity(
                opacity: _showFinalElements ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 800),
                child: Image.asset(
                  'assets/images/side maskot.png',
                  width: 200, // Slightly smaller or larger depending on original image size
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageItem extends StatefulWidget {
  final String text;
  final bool showLine;
  final bool isLast;
  final VoidCallback onComplete;

  const MessageItem({
    Key? key,
    required this.text,
    required this.showLine,
    required this.isLast,
    required this.onComplete,
  }) : super(key: key);

  @override
  State<MessageItem> createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showLine)
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: SizedBox(
              height: 24,
              child: CustomPaint(
                painter: DottedLinePainter(),
              ),
            ),
          ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: widget.isLast ? MediaQuery.of(context).size.width * 0.78 : MediaQuery.of(context).size.width * 0.65,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [Color(0xFFCEEEF3), Color(0xFFF2FBFC)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: TypewriterText(
              text: widget.text,
              style: GoogleFonts.inter(
                color: const Color(0xFF1E3A42),
                fontSize: 15,
                height: 1.5,
                fontWeight: FontWeight.w400,
              ),
              onComplete: widget.onComplete,
            ),
          ),
        ),
      ],
    );
  }
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4A6F75)
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;

    const dashHeight = 4.0;
    const dashSpace = 4.0;
    double startY = 0;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final VoidCallback onComplete;

  const TypewriterText({
    Key? key,
    required this.text,
    required this.style,
    required this.onComplete,
  }) : super(key: key);

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  int _charIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 35), (timer) {
      if (_charIndex < widget.text.length) {
        if (mounted) {
          setState(() {
            _charIndex++;
          });
        }
      } else {
        _timer.cancel();
        widget.onComplete();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.0,
          child: Text(widget.text, style: widget.style),
        ),
        Text(
          widget.text.substring(0, _charIndex),
          style: widget.style,
        ),
      ],
    );
  }
}
