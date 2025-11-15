import 'package:flutter/material.dart';
import 'small_bar_chart_demo.dart';

class AnalyticsPieChartBlock extends StatelessWidget {
  const AnalyticsPieChartBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Разбивка трат",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 14),
        Row(
          children: const [
            SizedBox(width: 12),
            Expanded(child: SmallBarChartDemo()),
          ],
        ),
      ],
    );
  }
}
