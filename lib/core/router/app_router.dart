import 'package:go_router/go_router.dart';
import 'package:own/core/router/domain/app_routes.dart';
import 'package:own/features/auth/presentation/screens/login_screen.dart';
import 'package:own/features/auth/presentation/screens/register_screen.dart';
import 'package:own/features/onboarding/presentation/screens/onboarding_screen.dart';


final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.onboarding,
  routes: <GoRoute>[
    GoRoute(
      path: AppRoutes.initial,
      name: 'initial',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      name: 'onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.register,
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),
    // GoRoute(
    //   path: AppRoutes.main,
    //   name: 'main',
    //   builder: (context, state) => const MainScreen(),
    // ),
  ],
);