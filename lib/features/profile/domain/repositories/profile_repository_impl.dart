import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  @override
  Future<UserEntity> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return UserEntity(
      id: 'user123',
      name: 'Мама',
      email: 'mama@example.com',
      isPremium: true,
      premiumUntil: DateTime(2025, 12, 12),
      isDarkModeEnabled: true,
    );
  }

  @override
  Future<void> toggleDarkMode(bool value) async {
    // TODO: SharedPreferences / Hive
    await Future.delayed(const Duration(milliseconds: 200));
  }

  @override
  Future<void> signOut() async {
    // TODO: FirebaseAuth.instance.signOut()
    await Future.delayed(const Duration(seconds: 1));
  }
}
