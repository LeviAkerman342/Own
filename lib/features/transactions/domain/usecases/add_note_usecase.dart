import 'package:own/features/transactions/domain/entities/note_entity.dart';
import 'package:own/features/transactions/domain/repositories/notes_repository.dart';

class AddTransactionUsecase {
  final TransactionsRepository repository;
  AddTransactionUsecase(this.repository);

  Future<void> call(TransactionEntity t) => repository.add(t);
}
