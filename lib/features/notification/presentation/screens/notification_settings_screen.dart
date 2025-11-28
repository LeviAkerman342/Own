// features/notification/presentation/screens/notification_settings_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:own/core/theme/model/color_collection.dart';
import '../../domain/entities/notification_setting.dart';
import '../cubit/notification_settings_cubit.dart';

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Настройки уведомлений',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<NotificationSettingsCubit, List<NotificationSetting>>(
        builder: (context, settings) {
          if (settings.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // СИНЯЯ КАРТОЧКА "Включить все уведомления"
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: ColorCollection.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.notifications_active,
                      color: ColorCollection.primary,
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Включить все уведомления',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Switch(
                      value: settings[0].isEnabled,
                      onChanged: (_) => context
                          .read<NotificationSettingsCubit>()
                          .toggleSetting('all'),
                      activeThumbColor: ColorCollection.primary,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Уведомления о тратах
              _buildSectionTitle('Уведомления о тратах'),
              const SizedBox(height: 12),
              ...settings.sublist(1, 4).map((s) => _buildTile(s, context)),

              const SizedBox(height: 32),

              // Уведомления о комнатах
              _buildSectionTitle('Уведомления о комнатах'),
              const SizedBox(height: 12),
              ...settings.sublist(4, 7).map((s) => _buildTile(s, context)),

              const SizedBox(height: 32),

              // Системные
              _buildSectionTitle('Системные и баланс'),
              const SizedBox(height: 12),
              ...settings.sublist(7).map((s) => _buildTile(s, context)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildTile(NotificationSetting setting, BuildContext context) {
    IconData icon;
    switch (setting.id) {
      case 'trap_limit_exceeded':
      case 'balance_updated':
        icon = Icons.warning_amber;
        break;
      case 'general_announcements':
        icon = Icons.campaign;
        break;
      default:
        icon = Icons.circle_notifications;
    }

    return SwitchListTile(
      secondary: Icon(icon, color: Colors.grey[700]),
      title: Text(setting.title),
      subtitle: setting.subtitle != null
          ? Text(
              setting.subtitle!,
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            )
          : null,
      value: setting.isEnabled,
      activeThumbColor: ColorCollection.primary,
      onChanged: (_) =>
          context.read<NotificationSettingsCubit>().toggleSetting(setting.id),
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
    );
  }
}
