import 'package:hive/hive.dart';
import '../../domain/entities/user_entity.dart';

part 'user_model.g.dart'; // 👈 обязательно

@HiveType(typeId: 0)
class UserModel extends UserEntity {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String role;
  @HiveField(2)
  final String avatarUrl;
  @HiveField(3)
  final double balance;

  const UserModel({
    required this.name,
    required this.role,
    required this.avatarUrl,
    required this.balance,
  }) : super(
          name: name,
          role: role,
          avatarUrl: avatarUrl,
          balance: balance,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'],
        role: json['role'],
        avatarUrl: json['avatarUrl'],
        balance: (json['balance'] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'role': role,
        'avatarUrl': avatarUrl,
        'balance': balance,
      };
}
