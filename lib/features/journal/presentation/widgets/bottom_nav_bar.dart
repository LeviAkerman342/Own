import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:own/core/router/domain/app_routes.dart';
import 'package:own/features/notes/presentation/screens/add_note_screen.dart';

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
    const blue = Color(0xFF3B82F6);
    const background = Color(0xFF0F111A);
    const iconSize = 26.0;

    return SafeArea(
      top: false,
      child: Container(
        height: 85,
        decoration: BoxDecoration(
          color: background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 🔹 Навигационные кнопки
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Row(
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
                      Icons.show_chart_rounded,
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
              ),
            ),

            // 🔵 Плавающая кнопка "+"
            Positioned(
              top: -28,
              child: GestureDetector(
                onTap: () {
                  context.push(AppRoutes.addNote);
                },

                child: Container(
                  height: 68,
                  width: 68,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2563EB), Color(0xFF60A5FA)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: blue.withOpacity(0.7),
                        blurRadius: 18,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                    size: 34,
                  ),
                ),
              ),
            ),
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
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Color(0xFF2563EB), Color(0xFF60A5FA)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : const Color(0xFF1C1F2A),
          shape: BoxShape.circle,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: activeColor.withOpacity(0.5),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
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
