import 'package:flutter/material.dart';
import 'package:own/features/analytics/data/models/transaction_model.dart';

class SpendingByUser extends StatelessWidget {
  final List<TransactionModel> data;
  const SpendingByUser({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Кто сколько потратил",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),

          ...data.map(
            (t) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                children: [
                  CircleAvatar(child: Icon(Icons.person)),
                  const SizedBox(width: 12),
                  Text(t.name, style: TextStyle(fontSize: 16)),
                  Spacer(),
                  Text(
                    "${t.amount > 0 ? '+' : ''}${t.amount} ₽",
                    style: TextStyle(
                      color: t.amount < 0 ? Colors.red : Colors.green,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
