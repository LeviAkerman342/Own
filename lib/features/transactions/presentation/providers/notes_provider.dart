import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';
import 'package:own/features/transactions/data/datasources/notes_local_data_source.dart';
import 'package:own/features/transactions/data/models/note_model.dart';
import 'package:own/features/transactions/data/repositories/notes_repository_impl.dart';
import 'package:own/features/transactions/domain/entities/note_entity.dart';
import 'package:own/features/transactions/domain/usecases/add_note_usecase.dart';

final transactionsProvider =
    StateNotifierProvider<TransactionsNotifier, List<TransactionEntity>>((ref) {
  final box = Hive.box<TransactionModel>('transactionsBox');
  final local = TransactionsLocalDataSource(box);
  final repo = TransactionsRepositoryImpl(local);
  final addUsecase = AddTransactionUsecase(repo);

  return TransactionsNotifier(addUsecase, repo);
});

class TransactionsNotifier extends StateNotifier<List<TransactionEntity>> {
  final AddTransactionUsecase addTransactionUsecase;
  final TransactionsRepositoryImpl repo;

  TransactionsNotifier(this.addTransactionUsecase, this.repo) : super([]) {
    loadTransactions();
  }

  Future<void> loadTransactions() async {
    final list = await repo.getAll();
    state = list;
  }

  Future<void> add(TransactionEntity entity) async {
    await addTransactionUsecase(entity);
    await loadTransactions();
  }

  Future<void> delete(String id) async {
    await repo.delete(id);
    await loadTransactions();
  }

  Future<void> update(TransactionEntity entity) async {
    await repo.update(entity);
    await loadTransactions();
  }

  Future<void> clearAll() async {
    await repo.local.clear();
    state = [];
  }
}
