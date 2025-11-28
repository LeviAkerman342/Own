import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:own/features/analytics/presentation/providers/analytics_provider.dart';
import 'package:own/features/analytics/widgets/analytics_pie_chart_block.dart';
import 'package:own/features/analytics/widgets/analytics_section_card.dart';
import 'package:own/features/analytics/widgets/spending_chart_card.dart';
import 'package:own/features/analytics/widgets/category_filter.dart';
import 'package:own/features/analytics/widgets/analytics_spent_list.dart.dart';
import 'package:own/features/analytics/widgets/filter_selector.dart';
import 'package:own/features/analytics/widgets/transaction_tile.dart';
import 'package:own/features/analytics/widgets/analytics_skeleton.dart';
import 'package:own/features/analytics/widgets/analytics_pie_card.dart';
import 'package:own/features/analytics/widgets/spending_by_user_card.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(analyticsProvider);

    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Аналитика",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),

              /// Категории (чипы)
              CategoryFilter(
                categories: const [
                  "Еда",
                  "Транспорт",
                  "Подписки",
                  "Покупки",
                  "Прочее",
                ],
                onSelect: (value) {},
              ),
              const SizedBox(height: 20),

              /// Pie chart + right bars
              const AnalyticsPieChartBlock(),
              const SizedBox(height: 20),

              /// Расходы по категориям — белая карточка
              AnalyticsSectionCard(
                title: "Расходы по категориям",
                child: const SpendingChartCard(),
              ),
              const SizedBox(height: 20),

              /// Кто сколько потратил — белая карточка
              const AnalyticsSpentList(),
              const SizedBox(height: 20),

              /// Фильтры (День / Месяц / Год)
              const FilterSelector(),
              const SizedBox(height: 20),

              /// Ещё один график
              AnalyticsSectionCard(
                title: "Динамика расходов",
                child: const SpendingChartCard(),
              ),
              const SizedBox(height: 20),

              /// Одна транзакция (если есть)
              if (state.transactions.isNotEmpty)
                AnalyticsSectionCard(
                  title: "Последняя операция",
                  child: TransactionTile(transaction: state.transactions.first),
                ),

              /// LOADING SKELETON
              if (state.isLoading) const AnalyticsSkeleton(),

              /// MAIN CONTENT
              if (!state.isLoading) ...[
                const SizedBox(height: 20),
                const AnalyticsPieCard(),
                const SizedBox(height: 20),
                SpendingByUser(data: state.transactions),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
