import 'package:flutter/material.dart';

class CenterAddButton extends StatelessWidget {
  const CenterAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: const Icon(Icons.add, color: Colors.white, size: 28),
    );
  }
}
