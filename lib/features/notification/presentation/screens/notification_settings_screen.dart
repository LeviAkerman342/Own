import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:own/core/theme/model/color_collection.dart';
import 'package:own/features/notification/domain/entities/notification_setting.dart';
import '../cubit/notification_settings_cubit.dart';

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Настройки уведомлений'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<NotificationSettingsCubit, List<NotificationSetting>>(
        builder: (context, settings) {
          if (settings.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          // Группировка как на скриншоте (индексы: 0=all, 1-3=траты, 4-6=комнаты, 7=системные)
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildMasterSwitch(context, settings[0]),
              const SizedBox(height: 24),
              _buildSection(
                'Уведомления о тратах',
                settings.sublist(1, 4),
                context,
              ),
              const SizedBox(height: 24),
              _buildSection(
                'Уведомления о комнатах',
                settings.sublist(4, 7),
                context,
              ),
              const SizedBox(height: 24),
              _buildSection('Системные и баланс', settings.sublist(7), context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMasterSwitch(BuildContext context, NotificationSetting setting) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: ColorCollection.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.notifications_active_outlined,
            color: ColorCollection.primary,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              setting.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Switch(
            value: setting.isEnabled,
            onChanged: (_) => context
                .read<NotificationSettingsCubit>()
                .toggleSetting(setting.id),
            activeThumbColor: ColorCollection.primary,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    String title,
    List<NotificationSetting> items,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        ...items.map((setting) => _buildSettingTile(setting, context)),
      ],
    );
  }

  Widget _buildSettingTile(NotificationSetting setting, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
        leading: Icon(
          _getIconForSetting(setting.id),
          color: Colors.grey[600],
          size: 24,
        ),
        title: Text(setting.title, style: const TextStyle(fontSize: 16)),
        subtitle: setting.subtitle != null
            ? Text(
                setting.subtitle!,
                style: TextStyle(fontSize: 14, color: Colors.grey[500]),
              )
            : null,
        trailing: Switch(
          value: setting.isEnabled,
          onChanged: (_) => context
              .read<NotificationSettingsCubit>()
              .toggleSetting(setting.id),
          activeThumbColor: ColorCollection.primary,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        tileColor: Colors.grey[50],
      ),
    );
  }

  IconData _getIconForSetting(String id) {
    switch (id) {
      case 'trap_limit_exceeded':
      case 'balance_updated':
        return Icons.warning_amber_outlined;
      case 'general_announcements':
        return Icons.campaign_outlined;
      case 'new_arrival_room':
      case 'new_invite_room':
        return Icons.group_outlined;
      default:
        return Icons.notifications_outlined;
    }
  }
}
