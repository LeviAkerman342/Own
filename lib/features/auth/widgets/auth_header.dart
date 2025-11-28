import 'package:flutter/material.dart';
import 'package:own/core/theme/model/color_collection.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool center;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.center = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: ColorCollection.gray900,
          ),
          textAlign: center ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 16,
            color: ColorCollection.gray700,
          ),
          textAlign: center ? TextAlign.center : TextAlign.left,
        ),
      ],
    );
  }
}
