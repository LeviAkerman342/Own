import 'package:hive/hive.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 2)
class TransactionModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final String category;

  @HiveField(3)
  final String? comment;

  @HiveField(4)
  final String? photoPath;

  @HiveField(5)
  final DateTime date;

  @HiveField(6)
  final String user;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.category,
    this.comment,
    this.photoPath,
    required this.date,
    required this.user,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'amount': amount,
        'category': category,
        'comment': comment,
        'photoPath': photoPath,
        'date': date.toIso8601String(),
        'user': user,
      };

  factory TransactionModel.fromMap(Map<dynamic, dynamic> map) {
    return TransactionModel(
      id: map['id'] as String,
      amount: (map['amount'] as num).toDouble(),
      category: map['category'] as String,
      comment: map['comment'] as String?,
      photoPath: map['photoPath'] as String?,
      date: DateTime.parse(map['date'] as String),
      user: map['user'] as String? ?? 'Пользователь',
    );
  }
}
