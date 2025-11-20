import '../entities/notification_setting.dart';
import '../repositories/notification_settings_repository.dart';

class GetNotificationSettings {
  final NotificationSettingsRepository repository;

  const GetNotificationSettings(this.repository);

  Future<List<NotificationSetting>> call() => repository.getSettings();
}
