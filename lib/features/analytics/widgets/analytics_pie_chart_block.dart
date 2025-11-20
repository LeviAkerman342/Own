import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalyticsPieChartBlock extends StatelessWidget {
  const AnalyticsPieChartBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          /// PIE CHART — ФИГМА СТИЛЬ
          Expanded(
            flex: 2,
            child: PieChart(
              PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 55,
                borderData: FlBorderData(show: false),
                sections: [
                  _section(44, "Еда", const Color(0xFF4CAF50)),
                  _section(9, "Еда", const Color(0xFF2196F3)),
                  _section(27, "Транспорт", const Color(0xFFFFC107)),
                  _section(20, "Покупки", const Color(0xFFF44336)),
                ],
              ),
            ),
          ),

          const SizedBox(width: 20),

          /// ПРАВАЯ КОЛОНКА – МИНИ-ГРАФИКИ
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [_MiniChartBlock(), _MiniChartBlock()],
            ),
          ),
        ],
      ),
    );
  }

  PieChartSectionData _section(double value, String title, Color color) {
    return PieChartSectionData(
      color: color,
      value: value,
      title: '$title\n${value.toInt()}%',
      radius: 55,
      titleStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }
}

class _MiniChartBlock extends StatelessWidget {
  const _MiniChartBlock();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xffF6F7FB),
        borderRadius: BorderRadius.circular(18),
      ),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceBetween,
          barGroups: [_bar(4), _bar(7), _bar(5)],
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: const FlTitlesData(show: false),
        ),
      ),
    );
  }

  BarChartGroupData _bar(double value) {
    return BarChartGroupData(
      x: value.toInt(),
      barRods: [
        BarChartRodData(
          toY: value,
          width: 8,
          borderRadius: BorderRadius.circular(6),
          color: const Color(0xFF2196F3),
        ),
      ],
    );
  }
}
