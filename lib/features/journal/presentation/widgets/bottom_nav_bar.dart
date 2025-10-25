import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black87,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(LucideIcons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(LucideIcons.barChart), label: 'Insight'),
        BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: ''),
        BottomNavigationBarItem(icon: Icon(LucideIcons.creditCard), label: 'Cards'),
        BottomNavigationBarItem(icon: Icon(LucideIcons.user), label: 'Account'),
      ],
    );
  }
}
