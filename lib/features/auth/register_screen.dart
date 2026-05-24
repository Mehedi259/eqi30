import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _agreeToTerms = false;
  bool _isLoading = false;

  late AnimationController _controller;
  late Animation<Offset> _headerSlideAnimation;
  late Animation<Offset> _nameSlideAnimation;
  late Animation<Offset> _emailSlideAnimation;
  late Animation<Offset> _passwordSlideAnimation;
  late Animation<Offset> _confirmPasswordSlideAnimation;
  late Animation<Offset> _buttonSlideAnimation;
  late Animation<Offset> _socialSlideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Very subtle upward slide with smooth fade
    _headerSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.02),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _nameSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.02),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _emailSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.02),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _passwordSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.02),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _confirmPasswordSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.02),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _buttonSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.02),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _socialSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.02),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Smooth, slow fade animation
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to terms and privacy')),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() => _isLoading = false);
        context.push('/verify-email');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(26),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                SlideTransition(
                  position: _headerSlideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(
                      'Register Account',
                      style: AppTextStyles.heading2.copyWith(
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SlideTransition(
                  position: _headerSlideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(
                      'Sign in with your email and password\nor social media to continue',
                      style: AppTextStyles.bodyMedium,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                SlideTransition(
                  position: _nameSlideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: CustomTextField(
                      label: 'Full Name',
                      hint: 'Your Name',
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                SlideTransition(
                  position: _emailSlideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: CustomTextField(
                      label: 'Email',
                      hint: 'brooklynsim@gm |',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                SlideTransition(
                  position: _passwordSlideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: CustomTextField(
                      label: 'Password',
                      controller: _passwordController,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                SlideTransition(
                  position: _confirmPasswordSlideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: CustomTextField(
                      label: 'Confirm Password',
                      controller: _confirmPasswordController,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                SlideTransition(
                  position: _confirmPasswordSlideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Row(
                      children: [
                        Checkbox(
                          value: _agreeToTerms,
                          onChanged: (value) {
                            setState(() => _agreeToTerms = value ?? false);
                          },
                          activeColor: AppColors.primaryDark,
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textPrimary,
                              ),
                              children: const [
                                TextSpan(text: 'Agree with '),
                                TextSpan(
                                  text: 'terms',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                TextSpan(text: ' and '),
                                TextSpan(
                                  text: 'privacy',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                SlideTransition(
                  position: _buttonSlideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: CustomButton(
                      text: 'Let\'s try a 2-minute exercise',
                      onPressed: _handleRegister,
                      isLoading: _isLoading,
                      icon: Icons.arrow_forward,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                SlideTransition(
                  position: _socialSlideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Center(
                      child: Text('Or', style: AppTextStyles.bodyMedium),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                SlideTransition(
                  position: _socialSlideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _SocialButton(icon: Icons.g_mobiledata, onTap: () {}),
                        const SizedBox(width: 16),
                        _SocialButton(icon: Icons.apple, onTap: () {}),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                SlideTransition(
                  position: _socialSlideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                          TextButton(
                            onPressed: () => context.go('/login'),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Sign in',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.primaryDark,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SocialButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Icon(icon, size: 32, color: AppColors.textPrimary),
      ),
    );
  }
}
