import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SpendBarChart extends StatelessWidget {
  const SpendBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BarChart(
          BarChartData(
            borderData: FlBorderData(show: false),
            gridData: const FlGridData(show: false),
            titlesData: const FlTitlesData(show: false),
            barGroups: [
              BarChartGroupData(x: 1, barRods: [
                BarChartRodData(toY: 10, color: Colors.redAccent, width: 12)
              ]),
              BarChartGroupData(x: 2, barRods: [
                BarChartRodData(toY: 6, color: Colors.orangeAccent, width: 12)
              ]),
              BarChartGroupData(x: 3, barRods: [
                BarChartRodData(toY: 8, color: Colors.greenAccent, width: 12)
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
