import 'package:go_router/go_router.dart';
import 'package:own/core/router/domain/app_routes.dart';
import 'package:own/features/auth/presentation/screens/login_screen.dart';
import 'package:own/features/auth/presentation/screens/register_screen.dart';
import 'package:own/features/journal/presentation/pages/main_page.dart';
import 'package:own/features/onboarding/presentation/screens/onboarding_screen.dart';

final router = GoRouter(
  initialLocation: AppRoutes.onboarding,
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
      path: AppRoutes.main,
      builder: (context, state) => const MainPage(),
    ),
  ],
);
