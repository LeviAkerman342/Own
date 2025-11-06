abstract class AuthRepository {
  Future<bool> login(String email, String password);
  Future<void> register(String email, String password);
}
