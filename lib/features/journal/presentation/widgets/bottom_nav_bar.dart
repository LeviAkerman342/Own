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
    return SafeArea(
      top: false,
      child: Container(
        height: 85,
        clipBehavior: Clip.none,
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: Colors.white.withOpacity(0.85),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          backgroundBlendMode: BlendMode.overlay,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // Навигация
            Positioned(
              bottom: 12,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _item(context, Icons.home_outlined, "Главная", 0),
                  _item(context, Icons.show_chart_rounded, "Аналитика", 1),
                  const SizedBox(width: 60),
                  _item(context, Icons.credit_card_outlined, "Карты", 2),
                  _item(context, Icons.person_outline, "Профиль", 3),
                ],
              ),
            ),

            Positioned(
              top: -26,
              child: GestureDetector(
                onTap: () => context.push(AppRoutes.addNote),
                child: Container(
                  height: 58,
                  width: 58,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(BuildContext context, IconData icon, String label, int index) {
    final isSelected = index == currentIndex;

    return GestureDetector(
      onTap: () {
        onTabSelected(index);
        _navigate(context, label);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 28,
            color: isSelected ? Colors.black : Colors.grey[500],
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isSelected ? Colors.black : Colors.grey[500],
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  void _navigate(BuildContext context, String label) {
    late String route;

    switch (label) {
      case "Главная":
        route = AppRoutes.jornal;
        break;
      case "Аналитика":
        route = AppRoutes.analitics;
        break;
      case "Карты":
        return;
      case "Профиль":
        route = AppRoutes.profile;
        break;
      default:
        return;
    }

    context.go(route);
  }
}
