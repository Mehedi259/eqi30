import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StartJourneyDetailScreen extends StatelessWidget {
  const StartJourneyDetailScreen({super.key});

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
                      child: const Icon(
                        Icons.arrow_back,
                        size: 16,
                        color: Color(0xFF0B191D),
                      ),
                    ),
                  ),
                  const Text(
                    'Start Journey',
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

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // Competency Badge and Recommended
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0x1443BDC7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Self Management',
                            style: TextStyle(
                              color: Color(0xFF43BDC7),
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Text(
                          'Recommended First',
                          style: TextStyle(
                            color: Color(0xFF637275),
                            fontSize: 11,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),

           