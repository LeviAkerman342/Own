import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:own/features/analytics/widgets/analytics_header.dart';
import 'package:own/features/analytics/widgets/analytics_pie_chart_block.dart';
import 'package:own/features/analytics/widgets/analytics_section_card.dart';
import 'package:own/features/analytics/widgets/analytics_spent_list.dart.dart';

import '../../presentation/providers/analytics_provider.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(analyticsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: const AnalyticsHeader(),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          AnalyticsSectionCard(child: AnalyticsPieChartBlock()),
          const SizedBox(height: 20),
          AnalyticsSectionCard(
            child: AnalyticsSpentList(transactions: transactions),
          ),
        ],
      ),
    );
  }
}
