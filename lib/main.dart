import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:own/features/auth/presentation/screens/login_screen.dart';
import 'package:own/features/auth/presentation/screens/register_screen.dart';
import 'package:own/features/journal/presentation/pages/journal_page.dart';
import 'package:own/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'core/storage/hive_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveStorage.init();
  runApp(const ProviderScope(child: FamilyNotesApp()));
}

class FamilyNotesApp extends StatelessWidget {
  const FamilyNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JournalPage(),
    );
  }
}

