import 'package:go_router/go_router.dart';
import '../../features/auth/splash_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/onboarding/ai_chat_onboarding_screen.dart';
import '../../features/onboarding/result_screen.dart' as onboarding;
import '../../features/onboarding/custom_journey_onboarding_screen.dart';
import '../../features/onboarding/journey_details_screen.dart';
import '../../features/onboarding/growth_pace_screen.dart';
import '../../features/onboarding/time_preference_screen.dart';
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
import '../../features/abilities/abilities_selection_screen.dart';
import '../../features/abilities/abilities_under_competency_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/profile/edit_profile_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/settings/security_screen.dart';
import '../../features/settings/change_password_screen.dart';
import '../../features/settings/privacy_terms_screen.dart';
import '../../features/settings/privacy_policy_screen.dart';
import '../../features/settings/terms_of_service_screen.dart';
import '../../features/settings/help_faq_screen.dart';
import '../../features/settings/subscription_screen.dart';
import '../../features/settings/reminder_screen.dart';
import '../../features/settings/goal_screen.dart';
import '../../features/resources/resources_screen.dart';
import '../../features/progress/progress_tracker_screen.dart';
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
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/ai-chat-onboarding',
        builder: (context, state) => const AiChatOnboardingScreen(),
      ),
      GoRoute(
        path: '/result-onboarding',
        builder: (context, state) => const onboarding.OnboardingResultScreen(),
      ),
      GoRoute(
        path: '/custom-journey-onboarding',
        builder: (context, state) => const CustomJourneyOnboardingScreen(),
      ),
      GoRoute(
        path: '/journey-details',
        builder: (context, state) => const JourneyDetailsScreen(),
      ),
      GoRoute(
        path: '/growth-pace',
        builder: (context, state) => const GrowthPaceScreen(),
      ),
      GoRoute(
        path: '/time-preference',
        builder: (context, state) => const TimePreferenceScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
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
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
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
        path: '/choose-journey',
        builder: (context, state) => const AbilitiesSelectionScreen(),
      ),
      GoRoute(
        path: '/abilities-under-competency',
        builder: (context, state) {
          final competencyId =
              state.uri.queryParameters['competencyId'] ?? 'self-management';
          final competencyName =
              state.uri.queryParameters['name'] ?? 'Self Management';
          final competencyColor =
              state.uri.queryParameters['color'] ?? '#43BDC7';
          return AbilitiesUnderCompetencyScreen(
            competencyId: competencyId,
            competencyName: competencyName,
            competencyColor: competencyColor,
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
        path: '/change-password',
        builder: (context, state) => const ChangePasswordScreen(),
      ),
      GoRoute(
        path: '/privacy-terms',
        builder: (context, state) => const PrivacyTermsScreen(),
      ),
      GoRoute(
        path: '/privacy-policy',
        builder: (context, state) => const PrivacyPolicyScreen(),
      ),
      GoRoute(
        path: '/terms-of-service',
        builder: (context, state) => const TermsOfServiceScreen(),
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
        path: '/reminder',
        builder: (context, state) => const ReminderScreen(),
      ),
      GoRoute(path: '/goal', builder: (context, state) => const GoalScreen()),
      GoRoute(
        path: '/resources',
        builder: (context, state) => const ResourcesScreen(),
      ),
      GoRoute(
        path: '/progress-tracker',
        builder: (context, state) => const ProgressTrackerScreen(),
      ),
      GoRoute(path: '/chat', builder: (context, state) => const ChatScreen()),
      GoRoute(
        path: '/feedback',
        builder: (context, state) => const FeedbackScreen(),
      ),
    ],
  );
}
