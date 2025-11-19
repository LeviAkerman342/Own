import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:own/features/transactions/domain/entities/note_entity.dart';
import 'package:own/features/transactions/domain/usecases/add_note_usecase.dart';
import 'package:own/features/transactions/domain/usecases/delete_note_usecase.dart';
import 'package:own/features/transactions/domain/usecases/get_notes_usecase.dart';
import 'package:own/features/transactions/domain/usecases/update_note_usecase.dart';

class TransactionsState {
  final List<TransactionEntity> items;
  final bool isLoading;
  TransactionsState({required this.items, this.isLoading = false});
}

class TransactionsCubit extends Cubit<TransactionsState> {
  final GetTransactionsUsecase getUsecase;
  final AddTransactionUsecase addUsecase;
  final UpdateTransactionUsecase updateUsecase;
  final DeleteTransactionUsecase deleteUsecase;

  TransactionsCubit({
    required this.getUsecase,
    required this.addUsecase,
    required this.updateUsecase,
    required this.deleteUsecase,
  }) : super(TransactionsState(items: [], isLoading: true)) {
    load();
  }

  Future<void> load() async {
    emit(TransactionsState(items: state.items, isLoading: true));
    final list = await getUsecase();
    emit(TransactionsState(items: list, isLoading: false));
  }

  Future<void> add(TransactionEntity t) async {
    emit(TransactionsState(items: state.items, isLoading: true));
    await addUsecase(t);
    await load();
  }

  Future<void> update(TransactionEntity t) async {
    emit(TransactionsState(items: state.items, isLoading: true));
    await updateUsecase(t);
    await load();
  }

  Future<void> delete(String id) async {
    emit(TransactionsState(items: state.items, isLoading: true));
    await deleteUsecase(id);
    await load();
  }
}
