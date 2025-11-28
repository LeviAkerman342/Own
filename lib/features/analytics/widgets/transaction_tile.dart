import 'package:flutter/material.dart';
import 'package:own/features/analytics/data/models/transaction_model.dart';

class TransactionTile extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionTile({required this.transaction, super.key});

  @override
  Widget build(BuildContext context) {
    final isNegative = transaction.amount < 0;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(transaction.avatarUrl),
            radius: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              transaction.name,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            "${transaction.amount > 0 ? '+' : ''}${transaction.amount} ₽",
            style: TextStyle(
              color: isNegative ? Colors.red : Colors.green,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
