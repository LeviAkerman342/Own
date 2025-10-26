import 'package:hive/hive.dart';


@HiveType(typeId: 0)
class UserModel {
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
  });

  // ✅ Для работы с API (JSON)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      role: json['role'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
      balance: (json['balance'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'role': role,
      'avatarUrl': avatarUrl,
      'balance': balance,
    };
  }
}
