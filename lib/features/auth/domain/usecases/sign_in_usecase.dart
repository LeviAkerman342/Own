import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<bool> call(String email, String password) async {
    if (email.isEmpty || !email.contains('@')) {
      throw Exception('Неверный формат email');
    }
    if (password.length < 6) {
      throw Exception('Минимум 6 символов в пароле');
    }

    return await repository.login(email, password);
  }
}
