import '../repositories/notification_settings_repository.dart';

class UpdateNotificationSetting {
  final NotificationSettingsRepository repository;
  const UpdateNotificationSetting(this.repository);

  Future<void> call({
    required String id,
    required bool isEnabled,
  }) => repository.updateSetting(id, isEnabled);
}