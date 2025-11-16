import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:own/features/analytics/data/models/analytics_filter.dart';
import 'package:own/features/analytics/presentation/providers/analytics_provider.dart';

class FilterSelector extends ConsumerWidget {
  const FilterSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(analyticsProvider).filter;

    Widget buildButton(String label, AnalyticsFilter value) {
      return GestureDetector(
        onTap: () => ref.read(analyticsProvider.notifier).changeFilter(value),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: selected == value ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black12),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected == value ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildButton("День", AnalyticsFilter.day),
        const SizedBox(width: 12),
        buildButton("Месяц", AnalyticsFilter.month),
        const SizedBox(width: 12),
        buildButton("Год", AnalyticsFilter.year),
      ],
    );
  }
}
