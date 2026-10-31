import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/custom_text_field.dart';
import '../../core/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _isLoading = false;

  late AnimationController _controller;
  late Animation<Offset> _headerSlideAnimation;
  late Animation<Offset> _emailSlideAnimation;
  late Animation<Offset> _passwordSlideAnimation;
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

    // Very subtle upward slide with smooth fade - same as journey-details
    _headerSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.02),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _socialSlideAnimation = Tween<Offset>(
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

    _buttonSlideAnimation = Tween<Offset>(
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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final _authService = AuthService();

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);

    try {
      await _authService.login(
        _emailController.text.trim(),
        _passwordController.text,
      );

      if (mounted) {
        setState(() => _isLoading = false);
        context.go('/home');
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

  Future<void> _handleSocialLogin(String provider) async {
    final defaultEmail = _emailController.text.trim().isNotEmpty
        ? _emailController.text.trim()
        : (provider == 'google' ? 'user@gmail.com' : 'user@icloud.com');

    final selectedEmail = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      backgroundColor: Colors.white,
      builder: (ctx) {
        final emailCtrl = TextEditingController(text: defaultEmail);
        return Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(
                    provider == 'google' ? Icons.g_mobiledata : Icons.apple,
                    size: 32,
                    color: provider == 'google' ? const Color(0xFF4285F4) : Colors.black,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    provider == 'google' ? 'Sign in with Google' : 'Sign in with Apple',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F1E3C),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Confirm the ${provider == 'google' ? 'Google' : 'Apple'} account for EQi30 authentication:',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: '${provider == 'google' ? 'Google' : 'Apple'} Account Email',
                  prefixIcon: Icon(
                    provider == 'google' ? Icons.mail_outline : Icons.apple,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final entered = emailCtrl.text.trim();
                    if (entered.isNotEmpty) {
                      Navigator.of(ctx).pop(entered);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: provider == 'google'
                        ? const Color(0xFF0F3B4A)
                        : Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Continue with ${provider == 'google' ? 'Google' : 'Apple'}',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (selectedEmail == null || selectedEmail.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      await _authService.socialLogin(
        provider: provider,
        email: selectedEmail,
        fullName: provider == 'google' ? 'Google User' : 'Apple User',
      );

      if (mounted) {
        setState(() => _isLoading = false);
        context.go('/home');
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
                const SizedBox(height: 24),
                // Header - Slides from left
                SlideTransition(
                  position: _headerSlideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome Back !',
                          style: AppTextStyles.heading2.copyWith(
                            color: AppColors.primaryDark,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Sign in with social media or your email to continue',
                          style: AppTextStyles.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Social buttons - Positioned at top per user request
                SlideTransition(
                  position: _socialSlideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      children: [
                        // Google Login Button
                        InkWell(
                          onTap: _isLoading ? null : () => _handleSocialLogin('google'),
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.03),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.g_mobiledata, size: 28, color: Color(0xFF4285F4)),
                                const SizedBox(width: 8),
                                Text(
                                  'Continue with Google',
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF0F1E3C),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Apple Login Button
                        InkWell(
                          onTap: _isLoading ? null : () => _handleSocialLogin('apple'),
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.08),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.apple, size: 22, color: Colors.white),
                                const SizedBox(width: 10),
                                Text(
                                  'Continue with Apple',
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Divider
                        Row(
                          children: [
                            const Expanded(child: Divider(color: Color(0xFFE2E8F0), thickness: 1)),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'Or with email',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF64748B),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const Expanded(child: Divider(color: Color(0xFFE2E8F0), thickness: 1)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Email field - Slides from right
                SlideTransition(
                  position: _emailSlideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: CustomTextField(
                      label: 'Email',
                      hint: 'example@gmail.com',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Password field - Slides from left
                SlideTransition(
                  position: _passwordSlideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: CustomTextField(
                      label: 'Password',
                      controller: _passwordController,
                      isPassword: true,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                SlideTransition(
                  position: _passwordSlideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() => _rememberMe = value ?? false);
                              },
                              activeColor: AppColors.primaryDark,
                            ),
                            Text(
                              'Remember me',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () => context.push('/forgot-password'),
                          child: Text(
                            'Forgot password ?',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Primary Button - "Continue" (updated from previous 'Let\'s try a 2-minute exercise')
                SlideTransition(
                  position: _buttonSlideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: CustomButton(
                      text: 'Continue',
                      onPressed: _handleLogin,
                      isLoading: _isLoading,
                      icon: Icons.arrow_forward,
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Sign up prompt
                SlideTransition(
                  position: _buttonSlideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account? ',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                          TextButton(
                            onPressed: () => context.push('/register'),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Sign up',
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

