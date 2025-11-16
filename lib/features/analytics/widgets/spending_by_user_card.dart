import 'package:flutter/material.dart';

class SpendingByUserCard extends StatelessWidget {
  const SpendingByUserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Кто сколько потратил",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),

          // Если нет данных
          Row(
            children: [
              Icon(Icons.hourglass_empty, size: 30, color: Colors.grey.shade400),
              const SizedBox(width: 12),
              Text(
                "Нет данных",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
