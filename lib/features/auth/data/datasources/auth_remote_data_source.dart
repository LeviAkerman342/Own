class AuthRemoteDataSource {
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    return email == "test@mail.com" && password == "123456";
  }

  Future<void> register(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    // имитация успешной регистрации
  }
}
