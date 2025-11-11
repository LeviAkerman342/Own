import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:own/core/router/domain/app_routes.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(context, Icons.home_outlined, "Главная", 0),
            _buildNavItem(context, Icons.insights_outlined, "Аналитика", 1),
            const SizedBox(width: 40),
            _buildNavItem(context, Icons.credit_card_outlined, "Карты", 2),
            _buildNavItem(context, Icons.person_outline, "Профиль", 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String label,
    int index,
  ) {
    final isSelected = index == currentIndex;

    return InkWell(
      onTap: () {
        onTabSelected(index);

        if (label == "Профиль") {
          context.go(AppRoutes.profile);
        } else if (label == "Аналитика") {
          context.go(AppRoutes.analitics);
        } else if (label == "Главная") {
          context.go(AppRoutes.jornal);
        } else if (label == "Карты") {
          // context.go(AppRoutes.cards);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isSelected ? Colors.black : Colors.grey),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
