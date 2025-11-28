import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import 'package:own/core/storage/hive_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<bool> login(String email, String password) async {
    final success = await remoteDataSource.login(email, password);
    if (success) {
      await HiveStorage.setUserEmail(email);
      await HiveStorage.setLoggedIn(true);
    }
    return success;
  }

  @override
  Future<void> register(String email, String password) async {
    await remoteDataSource.register(email, password);
    await HiveStorage.saveRegisteredUser(email, password);
  }
}
