import 'package:go_router/go_router.dart';
import 'package:myapp/features/auth/rooms/presentation/screens/rooms_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/rooms',
      builder: (context, state) => const RoomsScreen(),
    ),
  ],
);
