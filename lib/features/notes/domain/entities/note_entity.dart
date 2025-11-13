class NoteEntity {
  final String id;
  final String title;
  final double amount;
  final String category;
  final String currency;
  final DateTime date;
  final String? imagePath;

  NoteEntity({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.currency,
    required this.date,
    this.imagePath,
  });
}
