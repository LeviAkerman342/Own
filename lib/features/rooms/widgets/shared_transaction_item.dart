// lib/features/room/presentation/widgets/shared_transaction_item.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:own/features/rooms/domain/entities/room_entity.dart';

class SharedTransactionItem extends StatelessWidget {
  final SharedTransaction transaction;

  const SharedTransactionItem({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('d MMM, HH:mm');
    final dateStr = formatter.format(transaction.date);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF5E7CFF).withOpacity(0.15),
          child: const Icon(Icons.receipt_long, color: Color(0xFF5E7CFF)),
        ),
        title: Text(transaction.comment.isEmpty ? transaction.category : transaction.comment),
        subtitle: Text("${transaction.payerName} • $dateStr"),
        trailing: Text(
          "${transaction.amount.toStringAsFixed(0)} ₽",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}