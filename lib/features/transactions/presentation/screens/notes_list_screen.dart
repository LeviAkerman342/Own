import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import 'package:own/features/transactions/data/datasources/notes_local_data_source.dart';
import 'package:own/features/transactions/data/models/note_model.dart';
import 'package:own/features/transactions/data/repositories/notes_repository_impl.dart';

import 'package:own/features/transactions/domain/usecases/add_note_usecase.dart';
import 'package:own/features/transactions/domain/usecases/delete_note_usecase.dart';
import 'package:own/features/transactions/domain/usecases/get_notes_usecase.dart';
import 'package:own/features/transactions/domain/usecases/update_note_usecase.dart';

import 'package:own/features/transactions/presentation/cubit/notes_cubit.dart';
import 'package:own/features/transactions/widgets/note_card.dart';

class TransactionsListScreen extends StatelessWidget {
  const TransactionsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<TransactionModel>('transactionsBox');
    final local = TransactionsLocalDataSource(box);
    final repo = TransactionsRepositoryImpl(local);

    final cubit = TransactionsCubit(
      getUsecase: GetTransactionsUsecase(repo),
      addUsecase: AddTransactionUsecase(repo),
      updateUsecase: UpdateTransactionUsecase(repo),
      deleteUsecase: DeleteTransactionUsecase(repo),
    );

    return BlocProvider<TransactionsCubit>(
      create: (_) => cubit..load(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F7FB),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Журнал', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          elevation: 0,
        ),
        body: BlocBuilder<TransactionsCubit, TransactionsState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.items.isEmpty) {
              return Center(
                child: Text(
                  'Пока нет трат',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.items.length,
              itemBuilder: (ctx, i) => TransactionCard(
                transaction: state.items[i],
                onDelete: () =>
                    context.read<TransactionsCubit>().delete(state.items[i].id),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.push('/add-note'),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
