import 'package:flutter_bloc/flutter_bloc.dart';

class AddTransactionState {
  final bool isSaving;
  final String? error;
  AddTransactionState({this.isSaving = false, this.error});
}

class AddTransactionCubit extends Cubit<AddTransactionState> {
  AddTransactionCubit() : super(AddTransactionState());

  void saving() => emit(AddTransactionState(isSaving: true));

  void done() => emit(AddTransactionState(isSaving: false));

  void error(String message) => emit(AddTransactionState(isSaving: false, error: message));
}
