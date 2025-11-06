import 'package:flutter/material.dart';
import 'package:own/features/journal/domain/entities/user_entity.dart';

class UserSpendingCard extends StatelessWidget {
  final UserEntity user;

  const UserSpendingCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      child: ListTile(
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: Colors.grey[300],
          child: Text(user.name[0]), // первая буква имени
        ),

        title: Text(
          user.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: LinearProgressIndicator(
          value: (user.balance.abs() / 15000).clamp(0.0, 1.0),
          color: user.balance < 0 ? Colors.redAccent : Colors.green,
          backgroundColor: Colors.grey[200],
        ),
        trailing: Text(
          '${user.balance < 0 ? '' : '+'}${user.balance.toStringAsFixed(0)} ₽',
          style: TextStyle(
            color: user.balance < 0 ? Colors.redAccent : Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
