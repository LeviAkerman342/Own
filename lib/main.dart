import 'package:Own/core/router/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FamilyNotesApp());
}

class FamilyNotesApp extends StatelessWidget {
  const FamilyNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
