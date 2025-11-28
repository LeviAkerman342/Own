import '../datasources/journal_remote_source.dart';
import '../models/user_model.dart';
import '../../../../core/storage/hive_storage.dart';

class JournalRepository {
  final JournalRemoteSource remoteSource;

  JournalRepository(this.remoteSource);

  Future<List<UserModel>> getUsers() async {
    try {
      final users = await remoteSource.fetchUsers();
      await HiveStorage.saveUsers(users);
      return users;
    } catch (_) {
      final local = HiveStorage.getUsers();
      if (local.isNotEmpty) return local;
      rethrow;
    }
  }
}
