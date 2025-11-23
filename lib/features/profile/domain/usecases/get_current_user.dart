import '../entities/user_entity.dart';
import '../repositories/profile_repository.dart';

class GetCurrentUser {
  final ProfileRepository repository;

  GetCurrentUser(this.repository);

  Future<UserEntity> call() => repository.getCurrentUser();
}