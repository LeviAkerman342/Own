import 'package:flutter/material.dart';
import 'package:own/core/theme/model/color_collection.dart';

/// Глобальная тема приложения (светлая и тёмная)
class AppTheme {
  /// ☀️ Светлая тема
  static final light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: ColorCollection.background,
    primaryColor: ColorCollection.primary,
    colorScheme: const ColorScheme.light(
      primary: ColorCollection.primary,
      onPrimary: ColorCollection.white,
      secondary: ColorCollection.gray700,
      onSecondary: ColorCollection.white,
      surface: ColorCollection.white,
      onSurface: ColorCollection.gray800,
    ),

    /// 🔘 Кнопки
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorCollection.primary,
        foregroundColor: ColorCollection.white,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),

    /// 📋 Поля ввода
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorCollection.gray50,
      hintStyle: const TextStyle(color: ColorCollection.gray700),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: ColorCollection.gray300),
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: ColorCollection.gray300),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: ColorCollection.primary, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    /// 🎨 Стиль текста
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: ColorCollection.gray900,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: ColorCollection.gray800,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: ColorCollection.white,
      ),
    ),
  );

  /// 🌙 Тёмная тема (пригодится позже)
  static final dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ColorCollection.gray900,
    primaryColor: ColorCollection.primary,
    colorScheme: const ColorScheme.dark(
      primary: ColorCollection.primary,
      surface: ColorCollection.gray900,
      onSurface: ColorCollection.white,
    ),
  );
}
