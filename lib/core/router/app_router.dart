import 'package:Own/core/router/domain/app_routes.dart';
import 'package:Own/features/auth/presentation/screens/login_screen.dart';
import 'package:Own/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';


final router = GoRouter(
  initialLocation: AppRoutes.onboarding,
  routes: [
    GoRoute(
      path: AppRoutes.initial,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    // GoRoute(
    //   path: AppRoutes.register,
    //   builder: (context, state) => const AuthScreen(),
    // ),
    // GoRoute(
    //   path: AppRoutes.main,
    //   builder: (context, state) => const MainScreen(),
    // ),
  ],
);
