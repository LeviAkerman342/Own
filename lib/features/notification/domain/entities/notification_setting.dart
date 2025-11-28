class NotificationSetting {
  final String id;
  final String title;
  final String? subtitle;
  final bool isEnabled;

  const NotificationSetting({
    required this.id,
    required this.title,
    this.subtitle,
    required this.isEnabled,
  });

  NotificationSetting copyWith({bool? isEnabled}) {
    return NotificationSetting(
      id: id,
      title: title,
      subtitle: subtitle,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}
