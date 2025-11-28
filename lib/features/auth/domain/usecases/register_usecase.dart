import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<void> call(String email, String password, String confirmPassword) async {
    if (email.isEmpty || !email.contains('@')) {
      throw Exception('Неверный формат email');
    }
    if (password.length < 6) {
      throw Exception('Пароль должен содержать минимум 6 символов');
    }
    if (password != confirmPassword) {
      throw Exception('Пароли не совпадают');
    }

    await repository.register(email, password);
  }
}
