import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/services/journey_service.dart';
import 'package:intl/intl.dart';

class PreviousJourneyDetailsScreen extends StatefulWidget {
  final int abilityId;
  final String abilityName;

  const PreviousJourneyDetailsScreen({
    super.key,
    required this.abilityId,
    required this.abilityName,
  });

  @override
  State<PreviousJourneyDetailsScreen> createState() => _PreviousJourneyDetailsScreenState();
}

class _PreviousJourneyDetailsScreenState extends State<PreviousJourneyDetailsScreen> {
  final JourneyService _journeyService = JourneyService();
  bool _isLoading = true;
  List<dynamic> _history = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final data = await _journeyService.getAbilityHistory(widget.abilityId);
      if (mounted) {
        setState(() {
          _history = data['history'] ?? [];
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load history: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAFC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0B191D)),
          onPressed: () => context.pop(),
        ),
        title: Text(
          widget.abilityName,
          style: const TextStyle(
            color: Color(0xFF0B191D),
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        titleSpacing: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _history.isEmpty
              ? const Center(
                  child: Text(
                    'No completed sessions found for this journey.',
                    style: TextStyle(
                      color: Color(0xFF38434A),
                      fontSize: 14,
                      fontFamily: 'Inter',
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(26),
                  itemCount: _history.length,
                  itemBuilder: (context, index) {
                    final item = _history[index];
                    return _buildHistoryCard(item);
                  },
                ),
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> item) {
    final int dayNumber = item['content_day'] ?? 0;
    final String completedAtStr = item['completed_at'] ?? '';
    String dateStr = '';
    if (completedAtStr.isNotEmpty) {
      try {
        final date = DateTime.parse(completedAtStr).toLocal();
        dateStr = DateFormat('MMM d, yyyy').format(date);
      } catch (_) {}
    }

    final reflection = item['reflection'] as Map<String, dynamic>?;
    final String response = reflection?['response'] ?? '';
    final String reflectionText = reflection?['reflection_text'] ?? '';

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFFF0FDF4), // Light green tint
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Day $dayNumber',
                  style: const TextStyle(
                    color: Color(0xFF2E8B57),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  dateStr,
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 13,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
          
          // Body
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (reflection == null)
                  const Text(
                    'No reflection data for this session.',
                    style: TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  )
                else ...[
                  if (response.isNotEmpty) ...[
                    const Text(
                      'Feeling',
                      style: TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Text(
                        response,
                        style: const TextStyle(
                          color: Color(0xFF0F172A),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (reflectionText.isNotEmpty) ...[
                    const Text(
                      'Reflection',
                      style: TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      reflectionText,
                      style: const TextStyle(
                        color: Color(0xFF334155),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        height: 1.5,
                      ),
                    ),
                  ],
                  if (response.isEmpty && reflectionText.isEmpty)
                    const Text(
                      'Completed without reflection.',
                      style: TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    )
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
