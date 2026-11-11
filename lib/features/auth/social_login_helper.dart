import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/services/auth_service.dart';

/// Shared social authentication bottom-sheet flow used by Login and Register screens.
Future<bool> performSocialLoginFlow({
  required BuildContext context,
  required AuthService authService,
  required String provider,
  String? prefilledEmail,
  required ValueChanged<bool> onLoadingChanged,
}) async {
  final trimmed = (prefilledEmail ?? '').trim();
  final defaultEmail = trimmed.isNotEmpty
      ? trimmed
      : (provider == 'google' ? 'user@gmail.com' : 'user@icloud.com');

  final emailCtrl = TextEditingController(text: defaultEmail);
  final selectedEmail = await showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    backgroundColor: Colors.white,
    builder: (ctx) {
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
  emailCtrl.dispose();

  if (selectedEmail == null || selectedEmail.isEmpty) return false;

  onLoadingChanged(true);
  try {
    await authService.socialLogin(
      provider: provider,
      email: selectedEmail,
      fullName: provider == 'google' ? 'Google User' : 'Apple User',
    );
    onLoadingChanged(false);
    return true;
  } catch (e) {
    onLoadingChanged(false);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceAll('Exception: ', '')),
          backgroundColor: Colors.red,
        ),
      );
    }
    return false;
  }
}

