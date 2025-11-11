class AnalyticsEntity {
  final double totalAmount;
  final Map<String, double> categories;
  final List<TransactionEntity> transactions;

  AnalyticsEntity({
    required this.totalAmount,
    required this.categories,
    required this.transactions,
  });
}

class TransactionEntity {
  final String name;
  final double amount;
  final String category;
  final String imageUrl;

  TransactionEntity({
    required this.name,
    required this.amount,
    required this.category,
    required this.imageUrl,
  });
}
