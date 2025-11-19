
import 'package:own/features/transactions/domain/entities/note_entity.dart';
import 'package:own/features/transactions/domain/repositories/notes_repository.dart';

class UpdateTransactionUsecase {
  final TransactionsRepository repository;
  UpdateTransactionUsecase(this.repository);

  Future<void> call(TransactionEntity t) => repository.update(t);
}
