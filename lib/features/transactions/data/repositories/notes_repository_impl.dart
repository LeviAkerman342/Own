import 'package:own/features/transactions/data/datasources/notes_local_data_source.dart';
import 'package:own/features/transactions/data/models/note_model.dart';
import 'package:own/features/transactions/domain/entities/note_entity.dart';
import 'package:own/features/transactions/domain/repositories/notes_repository.dart';

class TransactionsRepositoryImpl implements TransactionsRepository {
  final TransactionsLocalDataSource local;

  TransactionsRepositoryImpl(this.local);

  @override
  Future<List<TransactionEntity>> getAll() async {
    final models = await local.getAll();

    return models
        .map(
          (m) => TransactionEntity(
            id: m.id,
            amount: m.amount,
            category: m.category,
            comment: m.comment,
            photoPath: m.photoPath,
            date: m.date,
            user: m.user,
          ),
        )
        .toList();
  }

  @override
  Future<void> add(TransactionEntity t) async {
    final model = TransactionModel(
      id: t.id,
      amount: t.amount,
      category: t.category,
      date: t.date,
      user: t.user,
    );

    await local.add(model as TransactionModel);
  }

  @override
  Future<void> update(TransactionEntity t) async {
    final model = TransactionModel(
      id: t.id,
      amount: t.amount,
      category: t.category,
      comment: t.comment,
      photoPath: t.photoPath,
      date: t.date,
      user: t.user,
    );

    await local.update(model);
  }

  @override
  Future<void> delete(String id) async {
    await local.delete(id);
  }
}
