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
            _buildHeader(context),
            
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    
                    // Category Badge and Recommendation
                    _buildCategoryRow(),
                    const SizedBox(height: 16),
                    
                    // Info Cards (What it is, Why it matters, What you'll do)
                    _buildInfoCards(),
                    const SizedBox(height: 16),
                    
                    // Journey Details (30-day, 5 min/day, 60 micro-skills)
                    _buildJourneyDetails(),
                    const SizedBox(height: 24),
                    
                    // What You'll Learn Section
                    _buildWhatYouLearnSection(),
                    const SizedBox(height: 24),
                    
                    // Journey Phases Section
                    _buildJourneyPhasesSection(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            
            // Bottom Action Buttons
            _buildBottomActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.10),
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(Icons.arrow_back, size: 16),
            ),
          ),
          const Expanded(
            child: Text(
              'Start Journey',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF0B191D),
                fontSize: 18,
                fontFamily: 'Archivo',
                fontWeight: FontWeight.w600,
                height: 1.11,
              ),
            ),
          ),
          const SizedBox(width: 24),
        ],
      ),
    );
  }

  Widget _buildCategoryRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
              height: 1.50,
            ),
          ),
        ),
        const Text(
          'Recommended First',
          style: TextStyle(
            color: Col