import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:own/core/router/domain/app_routes.dart';
import 'package:own/features/journal/data/mock_users.dart';
import 'package:own/features/journal/presentation/widgets/charts/spend_pie_chart.dart';
import 'package:own/features/journal/presentation/widgets/charts/spend_bar_chart.dart';
import 'package:own/features/journal/presentation/widgets/charts/user_spending_card.dart';
// import 'package:own/features/journal/presentation/widgets/user_spending_card.dart';
import 'package:own/features/journal/presentation/widgets/balance_card.dart';
import 'package:own/features/journal/presentation/widgets/bottom_nav_bar.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({super.key});

  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    //Считаем общий баланс
    final totalBalance = mockUsers.fold<double>(
      0,
      (sum, user) => sum + user.balance,
    );

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Аналитика семьи',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Общий баланс
            BalanceCard(amount: totalBalance),
            const SizedBox(height: 24),

            //  Графики
            const Text(
              'Разбивка трат',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: SizedBox(height: 200, child: SpendPieChart())),
                SizedBox(width: 12),
                Expanded(child: SizedBox(height: 200, child: SpendBarChart())),
              ],
            ),

            const SizedBox(height: 24),

            // 👨‍👩‍👧 Пользователи
            const Text(
              'Кто сколько потратил',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Column(
              children: mockUsers
                  .map((user) => UserSpendingCard(user: user))
                  .toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          context.push(AppRoutes.addNote);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTabSelected: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
