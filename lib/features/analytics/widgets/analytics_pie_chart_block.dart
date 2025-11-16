import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalyticsPieChartBlock extends StatelessWidget {
  const AnalyticsPieChartBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 40,
                sections: [
                  PieChartSectionData(
                    color: const Color(0xFFf44336),
                    value: 44,
                    title: 'Еда\n44%',
                    radius: 55,
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  PieChartSectionData(
                    color: const Color(0xFF2196f3),
                    value: 9,
                    title: 'Еда\n9%',
                    radius: 55,
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  PieChartSectionData(
                    color: const Color(0xFF4caf50),
                    value: 27,
                    title: 'Транспорт\n27%',
                    radius: 55,
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  PieChartSectionData(
                    color: const Color(0xFFff9800),
                    value: 20,
                    title: 'Покупки\n20%',
                    radius: 55,
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [_MiniBarChart(), _MiniBarChart()],
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniBarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barGroups: [_bar(6), _bar(3), _bar(7)],
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
        ),
      ),
    );
  }

  BarChartGroupData _bar(double value) => BarChartGroupData(
    x: value.toInt(),
    barRods: [
      BarChartRodData(
        toY: value,
        width: 10,
        borderRadius: BorderRadius.circular(4),
        color: const Color(0xFF1976d2),
      ),
    ],
  );
}
