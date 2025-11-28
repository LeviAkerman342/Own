import 'package:flutter/material.dart';

class SmallBarChartDemo extends StatelessWidget {
  const SmallBarChartDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(height: 60, color: Colors.transparent),
        const SizedBox(height: 10),
        Container(height: 60, color: Colors.transparent),
      ],
    );
  }
}
