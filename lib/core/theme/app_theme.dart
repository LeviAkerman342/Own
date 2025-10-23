import 'package:flutter/material.dart';
import 'package:own/core/theme/model/color_collection.dart';

final ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme.light(
    primary: ColorCollection.primary,
    onPrimary: ColorCollection.onPrimary,
    surface: ColorCollection.background,
  ),
  scaffoldBackgroundColor: ColorCollection.background,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      color: ColorCollection.textDark,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: ColorCollection.inputBackground,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: ColorCollection.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(vertical: 14),
      textStyle: const TextStyle(
        color: ColorCollection.textLight,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
);
