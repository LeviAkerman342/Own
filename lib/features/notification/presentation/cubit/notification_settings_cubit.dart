import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/notification_setting.dart';
import '../../domain/usecases/get_notification_settings.dart';
import '../../domain/usecases/update_notification_setting.dart';

class NotificationSettingsCubit extends Cubit<List<NotificationSetting>> {
  final GetNotificationSettings _getSettings;
  final UpdateNotificationSetting _updateSetting;

  NotificationSettingsCubit({
    required GetNotificationSettings getSettings,
    required UpdateNotificationSetting updateSetting,
  }) : _getSettings = getSettings,
       _updateSetting = updateSetting,
       super(const []) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final settings = await _getSettings();
    emit(settings);
  }

  Future<void> toggleSetting(String id) async {
    final currentState = state;
    final currentSetting = currentState.firstWhere((s) => s.id == id);
    final updatedSetting = currentSetting.copyWith(
      isEnabled: !currentSetting.isEnabled,
    );

    // Сохраняем в репозиторий
    await _updateSetting(id: id, isEnabled: updatedSetting.isEnabled);

    // Логика мастер-свитча
    List<NotificationSetting> newState;
    if (id == 'all') {
      // Включаем/выключаем все
      newState = currentState.map((s) {
        return s.id == 'all'
            ? updatedSetting
            : s.copyWith(isEnabled: updatedSetting.isEnabled);
      }).toList();
      // Сохраняем остальные
      for (final setting in newState.where((s) => s.id != 'all')) {
        await _updateSetting(id: setting.id, isEnabled: setting.isEnabled);
      }
    } else {
      newState = currentState
          .map((s) => s.id == id ? updatedSetting : s)
          .toList();
      // Проверяем, нужно ли обновить 'all'
      final allOthersEnabled = newState
          .where((s) => s.id != 'all')
          .every((s) => s.isEnabled);
      final allSetting = newState.firstWhere((s) => s.id == 'all');
      if (allSetting.isEnabled != allOthersEnabled) {
        final updatedAll = allSetting.copyWith(isEnabled: allOthersEnabled);
        await _updateSetting(id: 'all', isEnabled: allOthersEnabled);
        newState = newState.map((s) => s.id == 'all' ? updatedAll : s).toList();
      }
    }

    emit(newState);
  }
}
