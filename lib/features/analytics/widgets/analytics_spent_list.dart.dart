import 'package:flutter/material.dart';
import 'package:own/features/analytics/data/models/transaction_model.dart';
import 'transaction_tile.dart';

class AnalyticsSpentList extends StatelessWidget {
  final List<TransactionModel> transactions;

  const AnalyticsSpentList({
    required this.transactions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Кто сколько потратил",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        if (transactions.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Icon(Icons.hourglass_empty,
                    size: 38, color: Colors.grey.shade400),
                const SizedBox(height: 8),
                Text(
                  "Нет данных",
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          )
        else
          ...transactions.map(
            (t) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TransactionTile(transaction: t),
            ),
          ),
      ],
    );
  }
}
