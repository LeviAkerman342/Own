import 'package:flutter/material.dart';
import 'package:own/features/analytics/data/models/transaction_model.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;
  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(transaction.avatarUrl),
          radius: 24,
        ),
        title: Text(transaction.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(transaction.category),
        trailing: Text(
          "${transaction.amount.toStringAsFixed(0)} ₽",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
