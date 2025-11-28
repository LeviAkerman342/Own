class TransactionModel {
  final String name;
  final double amount;
  final String category;
  final String avatarUrl;
  final DateTime date;

  TransactionModel({
    required this.name,
    required this.amount,
    required this.category,
    required this.avatarUrl,
    required this.date,
  });
}
