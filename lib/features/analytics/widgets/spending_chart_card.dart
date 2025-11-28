import 'package:flutter/material.dart';

class SpendingChartCard extends StatelessWidget {
  const SpendingChartCard({super.key});

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
            "Разбивка трат",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),

          // Тут будут диаграммы (заглушка)
          SizedBox(
            height: 180,
            child: Center(
              child: Icon(
                Icons.pie_chart_outline,
                size: 80,
                color: Colors.grey.shade300,
              ),
            ),
          )
        ],
      ),
    );
  }
}
