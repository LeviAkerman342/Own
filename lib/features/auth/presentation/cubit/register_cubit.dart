import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:own/features/auth/domain/usecases/register_usecase.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterCubit(this.registerUseCase) : super(RegisterInitial());

  Future<void> register(String email, String password, String confirmPassword) async {
    emit(RegisterLoading());
    try {
      await registerUseCase(email, password, confirmPassword);
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
