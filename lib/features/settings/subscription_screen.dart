import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/settings_service.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final SettingsService _settingsService = SettingsService();
  final AuthService _authService = AuthService();

  bool _isLoading = true;
  String _activePlanCode = 'BASIC';
  String _activeStatus = 'FREE';
  List<Map<String, dynamic>> _plans = const [
    {
      'name': 'Basic',
      'code': 'BASIC',
      'price': '0.00',
      'billing_period': 'MONTHLY',
      'features': ['Access to the 30-day challenge', 'Daily learning content'],
    },
    {
      'name': 'Pro',
      'code': 'PRO',
      'price': '9.99',
      'billing_period': 'MONTHLY',
      'features': ['Everything in Basic', 'Full resources library', 'Progress insights'],
    },
    {
      'name': 'Premium',
      'code': 'PREMIUM',
      'price': '19.99',
      'billing_period': 'MONTHLY',
      'features': ['Everything in Pro', 'Meditation & yoga (coming soon)', 'Priority support'],
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadSubscription();
  }

  Future<void> _loadSubscription() async {
    try {
      final plans = await _settingsService.getSubscriptionPlans();
      String activeCode = _activePlanCode;
      String activeStatus = _activeStatus;
      if (await _authService.isLoggedIn()) {
        final statusData = await _settingsService.getSubscriptionStatus();
        final plan = statusData['plan'];
        if (plan is Map && plan['code'] != null) {
          activeCode = plan['code'].toString().toUpperCase();
        }
        activeStatus = (statusData['status'] ?? 'FREE').toString().toUpperCase();
      }
      if (mounted) {
        setState(() {
          if (plans.isNotEmpty) _plans = plans;
          _activePlanCode = activeCode;
          _activeStatus = activeStatus;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _onPlanTap(Map<String, dynamic> plan) {
    final code = (plan['code'] ?? '').toString().toUpperCase();
    final name = (plan['name'] ?? 'Plan').toString();
    if (code == _activePlanCode) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You are currently on the $name plan.')),
      );
      return;
    }
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('$name Plan'),
        content: Text(
          'In-app App Store / Play Store billing for $name is coming in the production release. Would you like to contact support for early organization access?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.push('/feedback');
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryDark),
            child: const Text('Contact Support', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

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
        title: Text(
          'Subscriptions',
          style: AppTextStyles.heading4,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Choose Your Plan',
                            style: AppTextStyles.heading2.copyWith(fontSize: 22),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0F2FE),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '$_activePlanCode • $_activeStatus',
                            style: const TextStyle(
                              color: Color(0xFF073B4B),
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Select the subscription that best fits your emotional growth journey. Upgrade or cancel anytime.',
                      style: AppTextStyles.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                    ..._plans.map((plan) {
                      final code = (plan['code'] ?? '').toString().toUpperCase();
                      final name = (plan['name'] ?? '').toString();
                      final rawPrice = double.tryParse((plan['price'] ?? '0').toString()) ?? 0;
                      final priceText = rawPrice == 0
                          ? '\$0'
                          : '\$${rawPrice.toStringAsFixed(2)}';
                      final period = (plan['billing_period'] ?? 'MONTHLY').toString().toUpperCase() == 'YEARLY'
                          ? '/yr'
                          : '/mo';
                      final features = (plan['features'] as List<dynamic>? ?? [])
                          .map((e) => e.toString())
                          .toList();
                      final isCurrent = code == _activePlanCode;
                      final isPro = code == 'PRO';

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _buildPlanCard(
                          title: name,
                          price: priceText,
                          period: period,
                          description: rawPrice == 0
                              ? 'Essential tools to begin your 30-ability EQ journey.'
                              : 'Unlock deeper resources, insights, and coaching support.',
                          features: features,
                          buttonText: isCurrent ? 'Current Plan' : 'Choose $name',
                          onTap: () => _onPlanTap(plan),
                          isHighlighted: isPro || isCurrent,
                          badge: isCurrent ? 'CURRENT PLAN' : (isPro ? 'BEST VALUE' : null),
                        ),
                      );
                    }),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String price,
    required String period,
    required String description,
    required List<String> features,
    required String buttonText,
    required VoidCallback onTap,
    bool isHighlighted = false,
    String? badge,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isHighlighted ? AppColors.primaryDark : AppColors.borderLight,
          width: isHighlighted ? 2 : 1,
        ),
        boxShadow: [
          if (isHighlighted)
            BoxShadow(
              color: AppColors.primaryDark.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (badge != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryDark,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                badge,
                style: AppTextStyles.badgeSmall.copyWith(fontSize: 10),
              ),
            ),
          if (badge != null) const SizedBox(height: 12),
          
          Text(
            title,
            style: AppTextStyles.heading4,
          ),
          const SizedBox(height: 8),
          
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                price,
                style: AppTextStyles.heading2.copyWith(fontSize: 32),
              ),
              Text(
                period,
                style: AppTextStyles.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          Text(
            description,
            style: AppTextStyles.bodySmall,
          ),
          const SizedBox(height: 16),
          
          ...features.map((feature) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: AppColors.accentGreen,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    feature,
                    style: AppTextStyles.bodySmall,
                  ),
                ),
              ],
            ),
          )),
          const SizedBox(height: 16),
          
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: isHighlighted
                    ? AppColors.primaryDark
                    : Colors.white,
                foregroundColor: isHighlighted
                    ? Colors.white
                    : AppColors.primaryDark,
                side: BorderSide(
                  color: AppColors.primaryDark,
                  width: isHighlighted ? 0 : 1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                buttonText,
                style: AppTextStyles.buttonMedium.copyWith(
                  color: isHighlighted
                      ? Colors.white
                      : AppColors.primaryDark,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
