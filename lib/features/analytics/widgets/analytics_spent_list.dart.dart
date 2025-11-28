import 'package:flutter/material.dart';

class AnalyticsSpentList extends StatelessWidget {
  const AnalyticsSpentList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _item("Папа", "-15 000 ₽", Colors.red),
        const SizedBox(height: 12),
        _item("Мама", "-15 000 ₽", Colors.red),
        const SizedBox(height: 12),
        _item("Мама Ребёнок", "+5 000 ₽", Colors.green),
        const SizedBox(height: 12),
        _item("Племянник", "+3 000 ₽", Colors.green),
      ],
    );
  }

  Widget _item(String name, String value, Color color) {
    return Row(
      children: [
        const CircleAvatar(radius: 18, backgroundColor: Colors.grey),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
