import 'package:flutter/material.dart';

class AnalyticsSkeleton extends StatelessWidget {
  const AnalyticsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        3,
        (_) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    );
  }
}
