class TransactionEntity {
  final String id;
  final double amount;
  final String category;
  final String? comment;
  final String? photoPath;
  final DateTime date;
  final String user;

  TransactionEntity({
    required this.id,
    required this.amount,
    required this.category,
    this.comment,
    this.photoPath,
    required this.date,
    required this.user,
  });
}
