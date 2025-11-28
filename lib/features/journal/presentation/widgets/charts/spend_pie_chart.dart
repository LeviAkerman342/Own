import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SpendPieChart extends StatelessWidget {
  const SpendPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: AspectRatio(
          aspectRatio: 1,
          child: PieChart(
            PieChartData(
              sectionsSpace: 4,
              centerSpaceRadius: 40,
              sections: [
                PieChartSectionData(
                  value: 44,
                  color: Colors.orangeAccent,
                  title: '44%',
                  radius: 40,
                  titleStyle: const TextStyle(
                      color: Colors.white, fontSize: 14),
                ),
                PieChartSectionData(
                  value: 27,
                  color: Colors.redAccent,
                  title: '27%',
                  radius: 40,
                  titleStyle: const TextStyle(
                      color: Colors.white, fontSize: 14),
                ),
                PieChartSectionData(
                  value: 30,
                  color: Colors.greenAccent,
                  title: '30%',
                  radius: 40,
                  titleStyle: const TextStyle(
                      color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
