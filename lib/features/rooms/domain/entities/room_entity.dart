import 'package:equatable/equatable.dart';

class RoomMember extends Equatable {
  final String id;
  final String name;
  final String? avatarUrl;
  final double totalSpent;

  const RoomMember({
    required this.id,
    required this.name,
    this.avatarUrl,
    this.totalSpent = 0,
  });

  @override
  List<Object?> get props => [id, name];
}

class SharedTransaction extends Equatable {
  final String id;
  final String payerName;
  final double amount;
  final String category;
  final DateTime date;
  final String comment;

  const SharedTransaction({
    required this.id,
    required this.payerName,
    required this.amount,
    required this.category,
    required this.date,
    required this.comment,
  });

  @override
  List<Object?> get props => [id];
}
