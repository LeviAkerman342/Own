import 'package:own/features/transactions/domain/entities/note_entity.dart';


abstract class TransactionsRepository {
  Future<List<TransactionEntity>> getAll();
  Future<void> add(TransactionEntity t);
  Future<void> update(TransactionEntity t);
  Future<void> delete(String id);
}
