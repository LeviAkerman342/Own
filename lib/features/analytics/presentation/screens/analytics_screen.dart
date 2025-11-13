import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:own/features/analytics/presentation/providers/analytics_provider.dart';
import 'package:own/features/analytics/widgets/analytics_pie.dart';
import 'package:own/features/analytics/widgets/back_button_widget.dart';
import 'package:own/features/analytics/widgets/transaction_card.dart';

import '../../data/models/transaction_model.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(analyticsProvider);

    const primary = Color(0xFF2A3D66);
    const accent = Color(0xFF5D9EFF);
    const background = Color(0xFFF6F8FC);

    return Scaffold(
      backgroundColor: background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BackButtonWidget(color: Colors.black, withBackground: true),
                  const Text(
                    "Project",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E1E2D),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.filter_list_rounded, color: Colors.black54),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          // 📊 Dashboard Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "OMP Dashboard",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1C1C1E),
                  ),
                ),
                SizedBox(height: 16),
                AnalyticsPie(),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // 🔹 Project Tasks Section
          const Text(
            "Project tasks",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Color(0xFF1C1C1E),
            ),
          ),
          const SizedBox(height: 12),

          // Filter buttons (All / Design / Frontend / Backend)
          Row(
            children: [
              for (final tab in ["All", "Design", "Frontend", "Backend"])
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Chip(
                    label: Text(tab),
                    backgroundColor:
                        tab == "All" ? accent : Colors.white,
                    labelStyle: TextStyle(
                      color: tab == "All" ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 16),

          // 🔸 Transactions
          if (transactions.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  Icon(Icons.hourglass_empty,
                      size: 42, color: Colors.grey.shade400),
                  const SizedBox(height: 12),
                  Text(
                    "Нет данных о транзакциях",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            )
          else
            ...transactions.map((t) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TransactionCard(transaction: t),
                )),
        ],
      ),

      // ➕ FAB
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: accent,
        icon: const Icon(Icons.add_rounded, size: 26),
        label: const Text(
          "Добавить",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        onPressed: () async {
          await ref.read(analyticsProvider.notifier).addTransaction(
                TransactionModel(
                  name: "Новая транзакция",
                  amount: 4200,
                  category: "Design",
                  avatarUrl: "https://randomuser.me/api/portraits/men/3.jpg",
                  date: DateTime.now(),
                ),
              );
        },
      ),
    );
  }
}
