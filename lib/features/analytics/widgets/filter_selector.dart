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
      final bool active = selected == value;
      return GestureDetector(
        onTap: () => ref.read(analyticsProvider.notifier).changeFilter(value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: active ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.black12),
            boxShadow: active
                ? [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            style: TextStyle(
              color: active ? Colors.white : Colors.black87,
              fontSize: 14,
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
