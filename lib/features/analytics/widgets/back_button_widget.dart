import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BackButtonWidget extends StatelessWidget {
  final Color color;
  final double size;
  final bool withBackground;

  const BackButtonWidget({
    super.key,
    this.color = Colors.white,
    this.size = 26,
    this.withBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pop(),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: withBackground ? color.withOpacity(0.15) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.arrow_back_ios_new_rounded, color: color, size: size),
      ),
    );
  }
}
