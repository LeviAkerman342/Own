import 'package:flutter/material.dart';

class NoteInputField extends StatelessWidget {
  final String label;
  final String? initialValue;
  final Function(String)? onChanged;
  final TextStyle? style;
  final TextAlign textAlign;
  final String? suffixText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;

  const NoteInputField({
    super.key,
    required this.label,
    this.initialValue,
    this.onChanged,
    this.style,
    this.textAlign = TextAlign.start,
    this.suffixText,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue,
          onChanged: onChanged,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textAlign: textAlign,
          style:
              style ??
              const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
          decoration: InputDecoration(
            hintText: '0',
            hintStyle: TextStyle(
              fontSize: style?.fontSize ?? 24,
              color: Colors.grey[400],
            ),
            suffixText: suffixText,
            suffixStyle:
                style ??
                const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
            prefixIcon: prefixIcon,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),
          ),
        ),
      ],
    );
  }
}
