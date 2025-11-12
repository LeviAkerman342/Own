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
    const blue = Color(0xFF007BFF);
    const iconSize = 26.0;

    return Container(
      height: 85,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(
                context,
                Icons.home_outlined,
                "Главная",
                0,
                blue,
                iconSize,
              ),
              _buildNavItem(
                context,
                Icons.insights_outlined,
                "Аналитика",
                1,
                blue,
                iconSize,
              ),
              const SizedBox(width: 70),
              _buildNavItem(
                context,
                Icons.credit_card_outlined,
                "Карты",
                2,
                blue,
                iconSize,
              ),
              _buildNavItem(
                context,
                Icons.person_outline,
                "Профиль",
                3,
                blue,
                iconSize,
              ),
            ],
          ),

          // 🔵 Плавающая кнопка “+”
          Positioned(
            top: -25,
            child: GestureDetector(
              onTap: () {
                // TODO: действие при нажатии "+"
              },
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: blue,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: blue.withOpacity(0.6),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String label,
    int index,
    Color activeColor,
    double iconSize,
  ) {
    final bool isSelected = index == currentIndex;

    return GestureDetector(
      onTap: () {
        onTabSelected(index);
        _navigateWithAnimation(context, label);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        height: 46,
        width: 46,
        decoration: BoxDecoration(
          color: isSelected
              ? activeColor
              : const Color.fromARGB(255, 80, 79, 79),
          shape: BoxShape.circle,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: activeColor.withOpacity(0.5),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.grey[500],
          size: iconSize,
        ),
      ),
    );
  }

  void _navigateWithAnimation(BuildContext context, String label) {
    late String route;
    switch (label) {
      case "Главная":
        route = AppRoutes.jornal;
        break;
      case "Аналитика":
        route = AppRoutes.analitics;
        break;
      case "Карты":
        // route = AppRoutes.cards;
        return;
      case "Профиль":
        route = AppRoutes.profile;
        break;
      default:
        return;
    }

    // ⚡ плавный переход
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (_, __, ___) => Container(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final offset =
              Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutQuart),
              );

          return SlideTransition(
            position: offset,
            child: FadeTransition(opacity: animation, child: child),
          );
        },
      ),
    );

    Future.delayed(const Duration(milliseconds: 100), () {
      context.go(route);
    });
  }
}
