// описание светлой/тёмной темы
import 'package:flutter/material.dart';

class AppTheme {
  static final light = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 252, 253, 255)),
    useMaterial3: true,
  );

  static final dark = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 1, 5, 1), brightness: Brightness.dark),
    useMaterial3: true,
  );
}
