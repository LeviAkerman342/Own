import '../entities/user_entity.dart';

abstract class ProfileRepository {
  Future<UserEntity> getCurrentUser();
  Future<void> toggleDarkMode(bool value);
  Future<void> signOut();
}