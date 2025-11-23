import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:own/features/rooms/presentation/cubit/rooms_cubit.dart';
import 'package:share_plus/share_plus.dart';


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
          actions: [
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () => Share.share("Присоединяйся к нашей семейной комнате трат! 👨‍👩‍👧\nhttps://own.app/join/room/abc123"),
            ),
          ],
        ),
        body: BlocBuilder<RoomCubit, RoomState>(
          builder: (context, state) {
            if (state is RoomLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is RoomLoaded) {
              return Column(
                children: [
                  // Участники
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                    ),
                    child: Column(
                      children: [
                        const Text("Участники", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        ...state.members.map((m) => RoomMemberCard(member: m)),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () => context.read<RoomCubit>().inviteViaContacts(),
                          icon: const Icon(Icons.person_add),
                          label: const Text("Пригласить из контактов"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5E7CFF),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Общие траты
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Последние траты", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: state.transactions.length,
                      itemBuilder: (ctx, i) => SharedTransactionItem(transaction: state.transactions[i]),
                    ),
                  ),
                ],
              );
            }

            return const Center(child: Text("Ошибка"));
          },
        ),
      ),
    );
  }
}