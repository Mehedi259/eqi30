import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/services/journey_service.dart';
import 'package:timeago/timeago.dart' as timeago;

class PreviousJourneyScreen extends StatefulWidget {
  const PreviousJourneyScreen({super.key});

  @override
  State<PreviousJourneyScreen> createState() => _PreviousJourneyScreenState();
}

class _PreviousJourneyScreenState extends State<PreviousJourneyScreen> {
  final JourneyService _journeyService = JourneyService();
  bool _isLoading = true;
  List<dynamic> _inProgress = [];
  List<dynamic> _completed = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final data = await _journeyService.getPreviousJourneyAbilities();
      if (mounted) {
        setState(() {
          _inProgress = data['in_progress'] ?? [];
          _completed = data['completed'] ?? [];
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load previous journey')),
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
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home');
            }
          },
        ),
        title: const Text(
          'Previous Journey',
          style: TextStyle(
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
          : SingleChildScrollView(
              padding: const EdgeInsets.all(26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_inProgress.isNotEmpty) ...[
                    const Text(
                      'IN PROGRESS',
                      style: TextStyle(
                        color: Color(0xFF38434A),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ..._inProgress.map((item) => Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: _buildInProgressCard(item),
                        )),
                    const SizedBox(height: 32),
                  ],
                  if (_completed.isNotEmpty) ...[
                    const Text(
                      'COMPLETED',
                      style: TextStyle(
                        color: Color(0xFF38434A),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ..._completed.map((item) => Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: _buildCompletedCard(item),
                        )),
                    const SizedBox(height: 40),
                  ],
                  if (_inProgress.isEmpty && _completed.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Text(
                          'No previous journey data found.',
                          style: TextStyle(
                            color: Color(0xFF38434A),
                            fontSize: 14,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }

  Widget _buildInProgressCard(Map<String, dynamic> item) {
    final int progressPercent = item['progress_percent'] ?? 0;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 4,
                color: const Color(0xFF2E8B57),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE5F5F8),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: item['icon'] != null
                                  ? Image.network(item['icon'], width: 24, height: 24)
                                  : const Text('💪', style: TextStyle(fontSize: 24)),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name'] ?? 'Ability',
                                  style: const TextStyle(
                                    color: Color(0xFF0B191D),
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Day ${item['current_day'] ?? 0} of ${item['total_days'] ?? 0}',
                                  style: const TextStyle(
                                    color: Color(0xFF38434A),
                                    fontSize: 13,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '$progressPercent%',
                            style: const TextStyle(
                              color: Color(0xFF2E8B57),
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Progress bar
                      Row(
                        children: [
                          Expanded(
                            flex: progressPercent,
                            child: Container(
                              height: 6,
                              decoration: BoxDecoration(
                                color: const Color(0xFF2E8B57),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                          if (progressPercent < 100)
                            Expanded(
                              flex: 100 - progressPercent,
                              child: Container(
                                height: 6,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE9ECF1),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompletedCard(Map<String, dynamic> item) {
    String completedAgo = '';
    if (item['completed_at'] != null) {
      final DateTime date = DateTime.parse(item['completed_at']);
      completedAgo = 'Completed ' + timeago.format(date);
    }
    final String subtitle = '$completedAgo  •  ${item['total_days'] ?? 0} days';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFFE5F5F8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: item['icon'] != null
                  ? Image.network(item['icon'], width: 28, height: 28)
                  : const Text('🧠', style: TextStyle(fontSize: 28)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'] ?? 'Ability',
                  style: const TextStyle(
                    color: Color(0xFF0B191D),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF38434A),
                    fontSize: 13,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
