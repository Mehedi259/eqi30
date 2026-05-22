import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/splash_screen.dart';
import '../../features/auth/login_screen.dart';
import '../../features/auth/register_screen.dart';
import '../../features/auth/forgot_password_screen.dart';
import '../../features/auth/verify_email_screen.dart';
import '../../features/auth/create_new_password_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/result/result_screen.dart';
import '../../features/journey/journey_screen.dart';
import '../../features/journey/custom_journey_screen.dart';
import '../../features/journey/start_journey_screen.dart';
import '../../features/abilities/abilities_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/profile/edit_profile_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/settings/security_screen.dart';
import '../../features/settings/privacy_terms_screen.dart';
import '../../features/settings/help_faq_screen.dart';
import '../../features/settings/subscription_screen.dart';
import '../../features/resources/resources_screen.dart';
import '../../features/chat/chat_screen.dart';
import '../../features/feedback/feedback_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      // Auth Routes
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/verify-email',
        builder: (context, state) => const VerifyEmailScreen(),
      ),
      GoRoute(
        path: '/create-new-password',
        builder: (context, state) => const CreateNewPasswordScreen(),
      ),
      
      // Main App Routes
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/result',
        builder: (context, state) => const ResultScreen(),
      ),
      GoRoute(
        path: '/journey',
        builder: (context, state) => const JourneyScreen(),
      ),
      GoRoute(
        path: '/custom-journey',
        builder: (context, state) => const CustomJourneyScreen(),
      ),
      GoRoute(
        path: '/start-journey',
        builder: (context, state) {
          final competencyId = state.uri.queryParameters['competencyId'] ?? '';
          return StartJourneyScreen(competencyId: competencyId);
        },
      ),
      GoRoute(
        path: '/abilities',
        builder: (context, state) {
          final competencyId = state.uri.queryParameters['competencyId'] ?? '';
          final competencyTitle = state.uri.queryParameters['title'] ?? '';
          return AbilitiesScreen(
            competencyId: competencyId,
            competencyTitle: competencyTitle,
          );
        },
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/edit-profile',
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/security',
        builder: (context, state) => const SecurityScreen(),
      ),
      GoRoute(
        path: '/privacy-terms',
        builder: (context, state) => const PrivacyTermsScreen(),
      ),
      GoRoute(
        path: '/help-faq',
        builder: (context, state) => const HelpFaqScreen(),
      ),
      GoRoute(
        path: '/subscription',
        builder: (context, state) => const SubscriptionScreen(),
      ),
      GoRoute(
        path: '/resources',
        builder: (context, state) => const ResourcesScreen(),
      ),
      GoRoute(
        path: '/chat',
        builder: (context, state) => const ChatScreen(),
      ),
      GoRoute(
        path: '/feedback',
        builder: (context, state) => const FeedbackScreen(),
      ),
    ],
  );
}
