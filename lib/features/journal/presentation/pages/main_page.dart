import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/shimmer_loading.dart';
import '../widgets/user_card.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUsers = ref.watch(userProvider);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Пользователи"),
        centerTitle: true,
        elevation: 0,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        child: asyncUsers.when(
          loading: () => const ShimmerLoading(),
          error: (e, _) => Center(child: Text("Ошибка: $e")),
          data: (users) {
            if (users.isEmpty) {
              return const Center(child: Text("Нет данных"));
            }

            return RefreshIndicator(
              onRefresh: () async {
                ref.refresh(userProvider);
              },
              child: ListView.builder(
                key: const ValueKey('userList'),
                padding: const EdgeInsets.all(16),
                itemCount: users.length,
                itemBuilder: (context, index) => UserCard(user: users[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
