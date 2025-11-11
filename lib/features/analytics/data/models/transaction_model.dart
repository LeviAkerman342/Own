import 'package:hive/hive.dart';


@HiveType(typeId: 0)
class TransactionModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final String category;

  @HiveField(3)
  final String avatarUrl;

  @HiveField(4)
  final DateTime date;

  TransactionModel({
    required this.name,
    required this.amount,
    required this.category,
    required this.avatarUrl,
    required this.date,
  });
}
