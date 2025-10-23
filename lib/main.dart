import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:own/core/router/app_router.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: FamilyNotesApp()));
}



class FamilyNotesApp extends StatelessWidget {
  const FamilyNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),      
      darkTheme: ThemeData.light(),   
      routerConfig: appRouter,
    );
  }
}