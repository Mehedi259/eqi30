import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LetsBreatheScreen extends StatefulWidget {
  const LetsBreatheScreen({super.key});

  @override
  State<LetsBreatheScreen> createState() => _LetsBreatheScreenState();
}

class _LetsBreatheScreenState extends State<LetsBreatheScreen> with SingleTickerProviderStateMixin {
  int _remainingSeconds = 104; // 01:44
  Timer? _countdownTimer;
  Timer? _breathingTimer;
  
  bool _isBreathingIn = true;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    // Animation for breathing effect
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4), // 4 seconds in, 4 seconds out
    );
    
    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isBreathingIn = false;
        });
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          _isBreathingIn = true;
        });
        _animationController.forward();
      }
    });

    _animationController.forward();

    // Countdown Timer
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _countdownTimer?.cancel();
        _breathingTimer?.cancel();
        _animationController.stop();
        if (mounted) {
          context.go('/privacy-pledge');
        }
      }
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _breathingTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  String get _formattedTime {
    int minutes = _remainingSeconds ~/ 60;
    int seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                // Back Button
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color(0xFFD3D3D3), // Light gray circle
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
                const SizedBox(height: 20),
                
                // Title & Subtitle
                Text(
                  "Let's Breathe",
                  style: GoogleFonts.inter(
                    color: const Color(0xFF1E3A42),
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Rest your mind. One breath at a time.",
                  style: GoogleFonts.inter(
                    color: const Color(0xFF4A6F75),
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 32),
                
                // Image with breathing animation
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        )
                      ],
                      image: const DecorationImage(
                        image: AssetImage('assets/images/lets breathe.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                
                // Timer Circle
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFF0F3B4A), width: 4),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _formattedTime,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF0F3B4A),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "REMAINING",
                        style: GoogleFonts.inter(
                          color: const Color(0xFF8A9A9D),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                
                // Follow the rhythm
                Text(
                  "Follow the rhythm",
                  style: GoogleFonts.inter(
                    color: const Color(0xFF0F3B4A),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 32),
                
                // Breathe In/Out text
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: const Color(0xFF0F3B4A), width: 2.5),
                  ),
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      text: "Breathe ",
                      style: GoogleFonts.inter(
                        color: const Color(0xFF1E3A42),
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                      children: [
                        TextSpan(
                          text: _isBreathingIn ? "In" : "Out",
                          style: GoogleFonts.inter(
                            color: const Color(0xFF4A909A), // Light teal color
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                
                // Relax your body text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Relax your body.",
                      style: GoogleFonts.inter(
                        color: const Color(0xFF4A6F75),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      "❤️",
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "Let your mind slow down.",
                      style: GoogleFonts.inter(
                        color: const Color(0xFF4A6F75),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Continue Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _countdownTimer?.cancel();
                      context.go('/privacy-pledge');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F3B4A),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Continue",
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
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
