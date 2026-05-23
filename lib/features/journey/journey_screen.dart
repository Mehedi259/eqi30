import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class JourneyScreen extends StatelessWidget {
  const JourneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text('Details', style: AppTextStyles.heading4),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Here\'s your guided journey',
                      style: AppTextStyles.heading2.copyWith(fontSize: 26),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'List the first 3 abilities here - Emotional Awareness Boundary Awareness Self-Confidence',
                      style: AppTextStyles.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                    // Before/After header
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'BEFORE',
                            style: AppTextStyles.heading5.copyWith(
                              color: AppColors.textPrimary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(width: 40),
                        Expanded(
                          child: Text(
                            'AFTER',
                            style: AppTextStyles.heading5.copyWith(
                              color: AppColors.textPrimary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Journey items
                    _buildJourneyItem(
                      context: context,
                      number: 1,
                      title: 'Self-management',
                      beforeImage: '😰',
                      beforeText: 'Not confident Frazzled',
                      afterImage: '🧘',
                      afterText: 'Confident Calm',
                      competencyId: 'self-management',
                      competencyColor: '#43BDC7',
                    ),
                    _buildJourneyItem(
                      context: context,
                      number: 2,
                      title: 'Interpersonal Management',
                      beforeImage: '😤',
                      beforeText: 'Fighting & Upset',
                      afterImage: '🤝',
                      afterText: 'Better Relationship',
                      competencyId: 'interpersonal',
                      competencyColor: '#FF6B9D',
                    ),
                    _buildJourneyItem(
                      context: context,
                      number: 3,
                      title: 'Spirit Management',
                      beforeImage: '😕',
                      beforeText: 'Sad & Confused',
                      afterImage: '⚡',
                      afterText: 'Energized & Connected',
                      competencyId: 'spirit',
                      competencyColor: '#FFB84D',
                    ),
                    _buildJourneyItem(
                      context: context,
                      number: 4,
                      title: 'Executive Functioning',
                      beforeImage: '😫',
                      beforeText: 'Too much to do',
                      afterImage: '✅',
                      afterText: 'Organized Efficient',
                      competencyId: 'executive',
                      competencyColor: '#9B59B6',
                    ),
                    _buildJourneyItem(
                      context: context,
                      number: 5,
                      title: 'Decision Making',
                      beforeImage: '🤔',
                      beforeText: 'Too many options',
                      afterImage: '🎯',
                      afterText: 'Decisive Clear',
                      competencyId: 'decision',
                      competencyColor: '#3498DB',
                    ),
                    _buildJourneyItem(
                      context: context,
                      number: 6,
                      title: 'Stress Management',
                      beforeImage: '😰',
                      beforeText: 'Hopeless Stressed',
                      afterImage: '😌',
                      afterText: 'Hopeful Peaceful',
                      competencyId: 'stress',
                      competencyColor: '#E74C3C',
                    ),
                  ],
                ),
              ),
            ),
            // Bottom buttons
            Container(
              padding: const EdgeInsets.all(24),
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
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to growth speed screen
                        _showGrowthSpeedBottomSheet(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryDark,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('NEXT', style: AppTextStyles.buttonLarge),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward, size: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {
                      context.push(
                        '/abilities?competencyId=self_management&title=Self-Management',
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.borderLight),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(double.infinity, 56),
                    ),
                    child: Text(
                      'Explore Abilities',
                      style: AppTextStyles.buttonLarge.copyWith(
                        color: AppColors.textPrimary,
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

  Widget _buildJourneyItem({
    required BuildContext context,
    required int number,
    required String title,
    required String beforeImage,
    required String beforeText,
    required String afterImage,
    required String afterText,
    required String competencyId,
    required String competencyColor,
  }) {
    return GestureDetector(
      onTap: () {
        context.push(
          '/abilities-under-competency?competencyId=$competencyId&name=$title&color=$competencyColor',
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryDark,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '$number',
                      style: AppTextStyles.heading5.copyWith(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.heading5.copyWith(fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                // Before
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(beforeImage, style: const TextStyle(fontSize: 40)),
                        const SizedBox(height: 8),
                        Text(
                          beforeText,
                          style: AppTextStyles.bodySmall.copyWith(fontSize: 11),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(
                  Icons.arrow_forward,
                  color: AppColors.primaryTeal,
                  size: 24,
                ),
                const SizedBox(width: 16),
                // After
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primaryCyan.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(afterImage, style: const TextStyle(fontSize: 40)),
                        const SizedBox(height: 8),
                        Text(
                          afterText,
                          style: AppTextStyles.bodySmall.copyWith(fontSize: 11),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showGrowthSpeedBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const GrowthSpeedBottomSheet(),
    );
  }
}

class GrowthSpeedBottomSheet extends StatefulWidget {
  const GrowthSpeedBottomSheet({super.key});

  @override
  State<GrowthSpeedBottomSheet> createState() => _GrowthSpeedBottomSheetState();
}

class _GrowthSpeedBottomSheetState extends State<GrowthSpeedBottomSheet> {
  int _selectedSpeed = 1; // 0: Low, 1: Medium, 2: High

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.borderLight,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Header
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Text(
                    'Details',
                    style: AppTextStyles.heading4,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'How fast do you want to grow?',
                    style: AppTextStyles.heading2.copyWith(fontSize: 26),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'You can change this anytime from your settings.',
                    style: AppTextStyles.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  // Speed options
                  _buildSpeedOption(
                    index: 0,
                    emoji: '🌱',
                    level: 'LOW',
                    title: '1 ability per day',
                    subtitle: '≈ 5 minutes daily',
                    color: AppColors.accentGreen,
                  ),
                  const SizedBox(height: 16),
                  _buildSpeedOption(
                    index: 1,
                    emoji: '🔥',
                    level: 'MEDIUM',
                    title: '2 abilities per day',
                    subtitle: '≈ 10 minutes daily',
                    color: AppColors.accentOrange,
                  ),
                  const SizedBox(height: 16),
                  _buildSpeedOption(
                    index: 2,
                    emoji: '🚀',
                    level: 'HIGH',
                    title: '3 abilities per day',
                    subtitle: '≈ 15 minutes daily',
                    color: AppColors.error,
                  ),
                ],
              ),
            ),
          ),
          // Bottom button
          Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showPracticeTimeBottomSheet(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryDark,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('NEXT', style: AppTextStyles.buttonLarge),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward, size: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpeedOption({
    required int index,
    required String emoji,
    required String level,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    final isSelected = _selectedSpeed == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSpeed = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.1) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : AppColors.borderLight,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 28)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    level,
                    style: AppTextStyles.labelSmall.copyWith(color: color),
                  ),
                  const SizedBox(height: 4),
                  Text(title, style: AppTextStyles.heading5),
                  const SizedBox(height: 2),
                  Text(subtitle, style: AppTextStyles.bodySmall),
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                child: const Icon(Icons.check, color: Colors.white, size: 16),
              )
            else
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderLight, width: 2),
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showPracticeTimeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const PracticeTimeBottomSheet(),
    );
  }
}

class PracticeTimeBottomSheet extends StatefulWidget {
  const PracticeTimeBottomSheet({super.key});

  @override
  State<PracticeTimeBottomSheet> createState() =>
      _PracticeTimeBottomSheetState();
}

class _PracticeTimeBottomSheetState extends State<PracticeTimeBottomSheet> {
  int _selectedTime =
      0; // 0: Morning, 1: Midday, 2: Evening, 3: Decide each day
  bool _dailyReminder = true;
  bool _missDayNudge = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.borderLight,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Header
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Text(
                    'Details',
                    style: AppTextStyles.heading4,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('✦ YOUR EQ SNAPSHOT', style: AppTextStyles.labelSmall),
                  const SizedBox(height: 8),
                  Text(
                    'When do practices fit best into your day?',
                    style: AppTextStyles.heading2.copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'We\'ll send a gentle reminder. You can change this anytime.',
                    style: AppTextStyles.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  // Time options
                  _buildTimeOption(
                    index: 0,
                    emoji: '🌅',
                    title: 'Morning',
                    subtitle: '6:00 – 9:00 AM',
                  ),
                  const SizedBox(height: 12),
                  _buildTimeOption(
                    index: 1,
                    emoji: '☀️',
                    title: 'Midday',
                    subtitle: '11:00 AM – 2:00 PM',
                  ),
                  const SizedBox(height: 12),
                  _buildTimeOption(
                    index: 2,
                    emoji: '🌙',
                    title: 'Evening',
                    subtitle: '7:00 – 10:00 PM',
                  ),
                  const SizedBox(height: 12),
                  _buildTimeOption(
                    index: 3,
                    emoji: '📅',
                    title: 'I\'ll decide each day',
                    subtitle: 'No fixed reminder',
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),
                  // Settings
                  _buildSettingRow(
                    icon: Icons.notifications_outlined,
                    title: 'Daily reminder',
                    subtitle: 'At your selected time',
                    value: _dailyReminder,
                    onChanged: (value) {
                      setState(() {
                        _dailyReminder = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildSettingRow(
                    icon: Icons.calendar_today_outlined,
                    title: 'Add to calendar',
                    subtitle: '5-min practice block daily',
                    isButton: true,
                  ),
                  const SizedBox(height: 16),
                  _buildSettingRow(
                    icon: Icons.chat_bubble_outline,
                    title: 'Miss-day nudge',
                    subtitle: 'Gentle reminder if 2 days pass',
                    value: _missDayNudge,
                    onChanged: (value) {
                      setState(() {
                        _missDayNudge = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          // Bottom buttons
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      context.go('/home');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryDark,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('CONTINUE', style: AppTextStyles.buttonLarge),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward, size: 20),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    context.push(
                      '/abilities?competencyId=self_management&title=Self-Management',
                    );
                  },
                  child: Text(
                    'See 30 Abilities',
                    style: AppTextStyles.link.copyWith(
                      decoration: TextDecoration.underline,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeOption({
    required int index,
    required String emoji,
    required String title,
    required String subtitle,
  }) {
    final isSelected = _selectedTime == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTime = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryCyan.withValues(alpha: 0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primaryCyan : AppColors.borderLight,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.heading5),
                  const SizedBox(height: 2),
                  Text(subtitle, style: AppTextStyles.bodySmall),
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: AppColors.primaryCyan,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 16),
              )
            else
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderLight, width: 2),
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingRow({
    required IconData icon,
    required String title,
    required String subtitle,
    bool? value,
    Function(bool)? onChanged,
    bool isButton = false,
  }) {
    return Row(
      children: [
        Icon(icon, color: AppColors.accentOrange, size: 24),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.heading5.copyWith(fontSize: 14)),
              const SizedBox(height: 2),
              Text(subtitle, style: AppTextStyles.bodySmall),
            ],
          ),
        ),
        if (isButton)
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primaryDark),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: Text(
              'Connect',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.primaryDark,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        else if (value != null && onChanged != null)
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primaryTeal,
          ),
      ],
    );
  }
}
