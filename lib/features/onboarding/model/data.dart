class _OnboardData {
  final String image;
  final String title;
  final String description;
  final String button;

  const _OnboardData({
    required this.image,
    required this.title,
    required this.description,
    required this.button,
  });
}

// ignore: library_private_types_in_public_api
final List<_OnboardData> pages = [
  _OnboardData(
    image: 'assets/images/onb_piggy.png',
    title: 'ВСЯ СЕМЬЯ В КУРСЕ',
    description:
        'Простой учёт общих расходов\nПриватные комнаты для группы\nНаглядная аналитика и бюджет\nФото чеков и быстрых вводов',
    button: 'Начать и контролировать',
  ),
  _OnboardData(
    image: 'assets/images/onb_team.png',
    title: 'ПРИВАТНЫЕ КОМНАТЫ ДЛЯ ВСЕХ',
    description:
        'Создавайте группы для семьи и друзей\nОтдельный учёт для общих трат\nПриватность и общий доступ одновременно',
    button: 'Продолжить',
  ),
];
