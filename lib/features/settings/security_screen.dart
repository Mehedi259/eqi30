import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/services/auth_service.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  final AuthService _authService = AuthService();
  bool _isDeleting = false;

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
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.arrow_back, size: 20),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Security',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF0B191D),
                        fontSize: 18,
                        fontFamily: 'Archivo',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(color: Color(0x14073B4B), blurRadius: 4),
                  ],
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => context.push('/change-password'),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Change Password',
                              style: TextStyle(
                                color: Color(0xFF0B191D),
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(Icons.chevron_right, color: Color(0xFF637275)),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 1,
                      color: Colors.black.withValues(alpha: 0.05),
                    ),
                    GestureDetector(
                      onTap: _isDeleting ? null : () => _showDeleteDialog(context),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _isDeleting ? 'Deleting...' : 'Delete Account',
                              style: const TextStyle(
                                color: Color(0xFFEF4444),
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            _isDeleting
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Color(0xFFEF4444),
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(
                                    Icons.delete_outline,
                                    color: Color(0xFFEF4444),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              setState(() => _isDeleting = true);
              try {
                await _authService.deleteAccount();
                if (mounted) {
                  context.go('/login');
                }
              } catch (e) {
                if (mounted) {
                  setState(() => _isDeleting = false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to delete account: $e')),
                  );
                }
              }
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Color(0xFFEF4444)),
            ),
          ),
        ],
      ),
    );
  }
}
