import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalyticsChart extends StatelessWidget {
  const AnalyticsChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Расходы по категориям",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 180,
              child: BarChart(
                BarChartData(
                  borderData: FlBorderData(show: false),
                  gridData: const FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  barGroups: [
                    BarChartGroupData(
                      x: 1,
                      barRods: [BarChartRodData(toY: 6, color: Colors.blue)],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [BarChartRodData(toY: 8, color: Colors.red)],
                    ),
                    BarChartGroupData(
                      x: 3,
                      barRods: [BarChartRodData(toY: 5, color: Colors.orange)],
                    ),
                    BarChartGroupData(
                      x: 4,
                      barRods: [BarChartRodData(toY: 9, color: Colors.green)],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
