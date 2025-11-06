import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:own/features/auth/domain/usecases/sign_in_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;

  AuthCubit(this.loginUseCase) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final success = await loginUseCase(email, password);
      if (success) {
        emit(AuthSuccess());
      } else {
        emit(AuthError('Неверный логин или пароль'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
