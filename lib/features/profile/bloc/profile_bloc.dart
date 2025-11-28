import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:own/features/profile/domain/entities/user_entity.dart';
import 'package:own/features/profile/domain/repositories/profile_repository.dart';


class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository repository;

  ProfileCubit(this.repository) : super(ProfileLoading()) {
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      final user = await repository.getCurrentUser();
      emit(ProfileLoaded(user as UserEntity));
    } catch (e) {
      emit(ProfileError('Не удалось загрузить профиль'));
    }
  }

  Future<void> toggleDarkMode(bool value) async {
    await repository.toggleDarkMode(value);
    if (state is ProfileLoaded) {
      final updated = (state as ProfileLoaded).user.copyWith(isDarkModeEnabled: value);
      emit(ProfileLoaded(updated));
    }
  }

  Future<void> signOut() async {
    await repository.signOut();
    emit(ProfileSignedOut());
  }
}

// States
abstract class ProfileState {}

class ProfileLoading extends ProfileState {}
class ProfileLoaded extends ProfileState {
  final UserEntity user;
  ProfileLoaded(this.user);
}
class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
class ProfileSignedOut extends ProfileState {}