import 'package:flutter/material.dart';
import 'package:own/core/theme/model/color_collection.dart';

class AuthTextField extends StatelessWidget {
  final String hint;
  final bool obscure;
  final TextEditingController controller;

  const AuthTextField({
    super.key,
    required this.hint,
    this.obscure = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: ColorCollection.textDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}
