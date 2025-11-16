import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AnalyticsHeader extends StatelessWidget {
  const AnalyticsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => context.pop(),
        ),
        const Expanded(
          child: Text(
            "Аналитика",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(width: 40), // для симметрии
      ],
    );
  }
}
