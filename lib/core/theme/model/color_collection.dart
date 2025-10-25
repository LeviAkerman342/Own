import 'dart:ui';

abstract class ColorCollection {
  /// Основной акцент — кнопка "Войти в аккаунт"
  static const primary = Color(0xFF2F80ED); // насыщенный сине-фиолетовый

  /// Цвет фона всего экрана
  static const background = Color(0xFFF5F6FA); // светло-серый, чуть холодный

  /// Очень светлый серый — фон текстовых полей
  static const gray50 = Color(0xFFF9FAFB);

  /// Светлый серый — бордеры или разделители
  static const gray300 = Color(0xFFE0E0E0);

  /// Средний серый — текст второстепенный
  static const gray700 = Color(0xFF828282);

  /// Тёмный серый — подзаголовки
  static const gray800 = Color(0xFF4F4F4F);

  /// Почти чёрный — заголовки
  static const gray900 = Color(0xFF1D1B20);

  /// Белый
  static const white = Color(0xFFFFFFFF);
}
