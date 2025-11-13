import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:own/core/router/domain/app_routes.dart';
import 'package:own/core/storage/hive_storage.dart';
import 'package:own/features/analytics/presentation/screens/analytics_screen.dart';
import 'package:own/features/auth/presentation/screens/login_screen.dart';
import 'package:own/features/auth/presentation/screens/register_screen.dart';
import 'package:own/features/journal/presentation/pages/journal_page.dart';
import 'package:own/features/notes/presentation/screens/add_note_screen.dart';
import 'package:own/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:own/features/profile/screen/profile_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  // читаем состояния из Hive
  final bool firstLaunch = HiveStorage.isFirstLaunch();
  final bool loggedIn = HiveStorage.isLoggedIn();

  //  определяем, с чего начать
  String initialLocation;
  if (firstLaunch) {
    initialLocation = AppRoutes.onboarding;
  } else if (!loggedIn) {
    initialLocation = AppRoutes.login;
  } else {
    initialLocation = AppRoutes.jornal;
  }

  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.jornal,
        builder: (context, state) => const JournalPage(),
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.analitics,
        builder: (context, state) => const AnalyticsScreen(),
      ),
      GoRoute(
        path: AppRoutes.addNote,
        builder: (context, state) => const AddNoteScreen(),
      ),
    ],
  );
});
