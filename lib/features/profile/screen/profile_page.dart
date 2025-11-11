import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:own/core/router/domain/app_routes.dart';
import 'package:own/core/storage/hive_storage.dart';
import '../widgets/profile_card.dart';
import '../widgets/profile_setting_tile.dart';
import '../widgets/logout_button.dart';
// import '../../domain/entities/user_profile_entity.dart';

// Провайдер для переключения темы
// final darkModeProvider = StateProvider<bool>((ref) => false);

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        title: const Text(
          "Профиль / Настройки",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.go(AppRoutes.jornal),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🧍‍♀️ Карточка профиля
            ProfileCard(),
            const SizedBox(height: 24),

            // 📦 Настройки
            const Text(
              "Аккаунт",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  ProfileSettingTile(
                    icon: Icons.dark_mode_outlined,
                    title: "Тёмная тема",
                    // trailing: Switch(
                    //   value: isDarkMode,
                    //   onChanged: (value) {
                    //     ref.read(darkModeProvider.notifier).state = value;
                    //   },
                    // ),
                  ),
                  const Divider(height: 0),
                  const ProfileSettingTile(
                    icon: Icons.download_outlined,
                    title: "Экспорт данных",
                    trailing: Icon(Icons.arrow_downward),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 🚪 Кнопка выхода
            LogoutButton(
              onPressed: () async {
                await HiveStorage.logout();
                if (context.mounted) {
                  context.go(AppRoutes.login);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
