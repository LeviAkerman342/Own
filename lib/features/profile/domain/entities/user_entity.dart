import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final bool isPremium;
  final DateTime? premiumUntil;
  final bool isDarkModeEnabled;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.isPremium = false,
    this.premiumUntil,
    this.isDarkModeEnabled = false,
  });

  UserEntity copyWith({
    String? id,
    String? name,
    String? email,
    bool? isPremium,
    DateTime? premiumUntil,
    bool? isDarkModeEnabled,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      isPremium: isPremium ?? this.isPremium,
      premiumUntil: premiumUntil ?? this.premiumUntil,
      isDarkModeEnabled: isDarkModeEnabled ?? this.isDarkModeEnabled,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    isPremium,
    premiumUntil,
    isDarkModeEnabled,
  ];
}
