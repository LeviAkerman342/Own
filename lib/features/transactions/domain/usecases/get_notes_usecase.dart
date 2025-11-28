import 'package:own/features/transactions/domain/entities/note_entity.dart';
import 'package:own/features/transactions/domain/repositories/notes_repository.dart';



class GetTransactionsUsecase {
  final TransactionsRepository repository;
  GetTransactionsUsecase(this.repository);

  Future<List<TransactionEntity>> call() => repository.getAll();
}
