import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:own/core/router/app_router.dart';
import 'package:own/core/router/domain/app_routes.dart';
import 'package:own/core/storage/hive_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveStorage.init();
  final startRoute = HiveStorage.isLoggedIn()
      ? AppRoutes.jornal
      : AppRoutes.onboarding;

  runApp(const ProviderScope(child: FamilyNotesApp()));
}

class FamilyNotesApp extends ConsumerWidget {
  const FamilyNotesApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
