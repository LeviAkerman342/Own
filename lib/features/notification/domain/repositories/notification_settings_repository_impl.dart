import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/notification_setting.dart';
import '../../domain/repositories/notification_settings_repository.dart';

class NotificationSettingsRepositoryImpl
    implements NotificationSettingsRepository {
  final SharedPreferences _prefs;

  const NotificationSettingsRepositoryImpl(this._prefs);

  static const String _prefix = 'notification_setting_';

  @override
  Future<List<NotificationSetting>> getSettings() async {
    return _defaultSettings.map((setting) {
      final savedValue =
          _prefs.getBool('${_prefix}${setting.id}') ?? setting.isEnabled;
      return setting.copyWith(isEnabled: savedValue);
    }).toList();
  }

  @override
  Future<void> updateSetting(String id, bool isEnabled) async {
    await _prefs.setBool('${_prefix}$id', isEnabled);
  }

  static const List<NotificationSetting> _defaultSettings = [
    NotificationSetting(
      id: 'all',
      title: 'Включить все уведомления',
      isEnabled: true,
    ),
    NotificationSetting(
      id: 'new_trap_room',
      title: 'Новая трата в комнате',
      isEnabled: true,
    ),
    NotificationSetting(
      id: 'my_trap_added',
      title: 'Мои траты добавлены',
      isEnabled: true,
    ),
    NotificationSetting(
      id: 'trap_limit_exceeded',
      title: 'Траты превышает лимит',
      subtitle: 'Предупреждение о превышении',
      isEnabled: true,
    ),
    NotificationSetting(
      id: 'new_arrival_room',
      title: 'Новое прибытие в комнату',
      isEnabled: true,
    ),
    NotificationSetting(
      id: 'new_invite_room',
      title: 'Новое приглашение в комнату',
      isEnabled: true,
    ),
    NotificationSetting(
      id: 'balance_updated',
      title: 'Убаланс в комнате',
      subtitle: 'Изменения баланса',
      isEnabled: true,
    ),
    NotificationSetting(
      id: 'general_announcements',
      title: 'Объявления прибытия',
      isEnabled: true,
    ),
  ];
}
