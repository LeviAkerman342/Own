import 'package:flutter/material.dart';

class SettingsSection extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) onDarkModeChanged;

  const SettingsSection({
    super.key,
    required this.isDarkMode,
    required this.onDarkModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Настройки Приложения',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _tile(
          Icons.dark_mode_outlined,
          'Темная тема',
          trailing: Switch(value: isDarkMode, onChanged: onDarkModeChanged),
        ),
        _tile(Icons.notifications_outlined, 'Уведомления'),
        _tile(Icons.language, 'Язык', trailing: const Text('Русский')),
        _tile(Icons.download, 'Экспорт данных'),
      ],
    );
  }

  Widget _tile(IconData icon, String title, {Widget? trailing}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          // ignore: deprecated_member_use
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 15),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black54),
          const SizedBox(width: 16),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 16))),
          trailing ?? const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
