import '../entities/notification_setting.dart';

abstract class NotificationSettingsRepository {
  Future<List<NotificationSetting>> getSettings();
  Future<void> updateSetting(String id, bool isEnabled);
}