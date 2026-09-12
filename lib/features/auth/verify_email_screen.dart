import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../shared/widgets/custom_button.dart';
import '../../core/services/auth_service.dart';

class VerifyEmailScreen extends StatefulWidget {
  final bool isFromRegister;
  const VerifyEmailScreen({super.key, this.isFromRegister = true});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final _pinController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  final _authService = AuthService();

  Future<void> _handleVerify() async {
    if (_pinController.text.length == 6) {
      setState(() => _isLoading = true);
      
      try {
        if (widget.isFromRegister) {
          await _authService.verifyEmail(_pinController.text);
          if (mounted) {
            setState(() => _isLoading = false);
            context.go('/home'); // Skip onboarding for now, go straight to home
          }
        } else {
          await _authService.verifyOtp(_pinController.text);
          if (mounted) {
            setState(() => _isLoading = false);
            context.push('/create-new-password', extra: _pinController.text);
          }
        }
      } catch (e) {
        if (mounted) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString().replaceAll('Exception: ', '')),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: AppTextStyles.heading3,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderLight),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryTeal, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                'Verify your Email',
                style: AppTextStyles.heading2.copyWith(
                  color: AppColors.primaryDark,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please enter 6 digit verification that have been sent to your email address',
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: 40),
              
              Center(
                child: Pinput(
                  controller: _pinController,
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  onCompleted: (pin) => _handleVerify(),
                ),
              ),
              const SizedBox(height: 24),
              
              Center(
                child: Column(
                  children: [
                    Text(
                      'Don\'t receive code ?',
                      style: AppTextStyles.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Resend code',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              
              CustomButton(
                text: 'Let\'s try a 2-minute exercise',
                onPressed: _handleVerify,
                isLoading: _isLoading,
                icon: Icons.arrow_forward,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
