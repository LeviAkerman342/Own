import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:own/features/analytics/presentation/providers/analytics_provider.dart';
import '../widgets/analytics_chart.dart';
import '../widgets/analytics_pie.dart';
import '../widgets/transaction_card.dart';
import '../../data/models/transaction_model.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(analyticsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A3D66),
        elevation: 0,
        title: const Text("Аналитика", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.white),
            onPressed: () =>
                ref.read(analyticsProvider.notifier).clearTransactions(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const AnalyticsChart(),
            const AnalyticsPie(),
            const SizedBox(height: 12),
            const Text(
              "Транзакции",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            if (transactions.isEmpty) const Center(child: Text("Нет данных")),
            ...transactions
                .map((t) => TransactionCard(transaction: t))
                .toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2A3D66),
        onPressed: () async {
          await ref
              .read(analyticsProvider.notifier)
              .addTransaction(
                TransactionModel(
                  name: "Ega",
                  amount: 5200,
                  category: "Food",
                  avatarUrl: "https://randomuser.me/api/portraits/women/1.jpg",
                  date: DateTime.now(),
                ),
              );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
