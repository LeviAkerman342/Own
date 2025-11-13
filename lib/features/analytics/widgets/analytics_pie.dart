import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalyticsPie extends StatelessWidget {
  const AnalyticsPie({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Кто сколько потратил", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SizedBox(
              height: 150,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(value: 40, color: Colors.blue, title: 'Ega'),
                    PieChartSectionData(value: 30, color: Colors.red, title: 'Рекл.'),
                    PieChartSectionData(value: 30, color: Colors.orange, title: 'Пр.'),
                  ],
                  borderData: FlBorderData(show: false),
                  centerSpaceRadius: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
