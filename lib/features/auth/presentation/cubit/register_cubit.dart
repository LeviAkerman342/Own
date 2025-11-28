import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> register(String email, String password, String confirmPassword) async {
    emit(RegisterLoading());

    try {
      if (password != confirmPassword) {
        emit(RegisterError('Пароли не совпадают'));
        return;
      }

      final prefs = await SharedPreferences.getInstance();

      // Проверим, зарегистрирован ли уже пользователь
      final existingUser = prefs.getString('user_email');
      if (existingUser != null && existingUser == email) {
        emit(RegisterError('Пользователь с таким e-mail уже существует'));
        return;
      }

      // Сохраним данные “в базу”
      await prefs.setString('user_email', email);
      await prefs.setString('user_password', password);

      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterError('Ошибка при регистрации: $e'));
    }
  }
}
