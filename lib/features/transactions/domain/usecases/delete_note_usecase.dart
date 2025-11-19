
import 'package:own/features/transactions/domain/repositories/notes_repository.dart';

class DeleteTransactionUsecase {
  final TransactionsRepository repository;
  DeleteTransactionUsecase(this.repository);

  Future<void> call(String id) => repository.delete(id);
}
