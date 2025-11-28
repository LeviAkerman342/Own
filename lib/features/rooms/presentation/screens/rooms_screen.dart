// lib/features/rooms/presentation/screens/room_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:own/features/rooms/presentation/cubit/room_state.dart';
import 'package:own/features/rooms/widgets/%20room_card.dart';
import 'package:own/features/rooms/widgets/shared_transaction_item.dart'; 
import 'package:share_plus/share_plus.dart';

import '../cubit/rooms_cubit.dart';

class RoomScreen extends StatelessWidget {
  const RoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RoomCubit(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFF),
        appBar: AppBar(
          title: const Text("Семейная комната"),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.share_outlined),
              onPressed: () {
                // Берём данные из Cubit
                final state = context.read<RoomCubit>().state;
                if (state is RoomLoaded) {
                  final description = state.roomDescription.isNotEmpty
                      ? state.roomDescription
                      : "Семейная комната трат";

                  Share.share(
                    "Присоединяйся к нашей комнате «$description»!\n\n"
                    "Код: ${state.inviteCode}\n"
                    "Ссылка: https://own.app/join/room/${state.inviteCode}\n\n"
                    "Вместе следить за расходами — проще и честнее!",
                    subject: "Приглашение в Own — общие траты",
                  );
                }
              },
            ),
          ],
        ),
        body: BlocBuilder<RoomCubit, RoomState>(
          builder: (context, state) {
            // 1. Загрузка
            if (state is RoomLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            // 2. Данные загружены
            if (state is RoomLoaded) {
              final canInvite = state.memberCount < state.maxMembers;

              return Column(
                children: [
                  // УЧАСТНИКИ
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Участники", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            Text(
                              "${state.memberCount}/${state.maxMembers}",
                              style: TextStyle(
                                color: canInvite ? Colors.green.shade600 : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ...state.members.map((m) => RoomMemberCard(member: m)),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: canInvite ? () => context.push('/invite') : null,
                          icon: const Icon(Icons.person_add),
                          label: Text(canInvite ? "Пригласить участника" : "Лимит 5/5 достигнут"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: canInvite ? const Color(0xFF5E7CFF) : Colors.grey,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // БАЛАНС
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Расчёты", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        if (state.balance.isEmpty)
                          const Text("Все в расчёте!", style: TextStyle(color: Colors.grey))
                        else
                          ...state.balance.entries.map((e) {
                            final name = e.key;
                            final amount = e.value;
                            final positive = amount > 0;

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
                                  Text(
                                    positive
                                        ? "+${amount.toStringAsFixed(0)} ₽ тебе должны"
                                        : "${amount.abs().toStringAsFixed(0)} ₽ ты должен",
                                    style: TextStyle(
                                      color: positive ? Colors.green.shade600 : Colors.red.shade600,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Последние траты", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ТРАНЗАКЦИИ
                  Expanded(
                    child: state.transactions.isEmpty
                        ? const Center(child: Text("Пока нет трат в этой комнате"))
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemCount: state.transactions.length,
                            itemBuilder: (ctx, i) => SharedTransactionItem(
                              transaction: state.transactions[i],
                            ),
                          ),
                  ),
                ],
              );
            }

            // 3. Если что-то пошло не так (на всякий случай)
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red),
                  SizedBox(height: 16),
                  Text("Не удалось загрузить комнату", style: TextStyle(fontSize: 16)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}