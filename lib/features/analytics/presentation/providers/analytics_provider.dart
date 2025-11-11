import 'package:flutter_riverpod/legacy.dart';
import 'package:own/core/storage/transaction_hive.dart';
import 'package:own/features/analytics/data/models/transaction_model.dart';


final analyticsProvider = StateNotifierProvider<AnalyticsNotifier, List<TransactionModel>>((ref) {
  return AnalyticsNotifier();
});

class AnalyticsNotifier extends StateNotifier<List<TransactionModel>> {
  AnalyticsNotifier() : super([]) {
    _loadFromHive();
  }

  Future<void> _loadFromHive() async {
    state = TransactionHiveService.getAll();
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    await TransactionHiveService.add(transaction);
    state = TransactionHiveService.getAll();
  }

  Future<void> clearTransactions() async {
    await TransactionHiveService.clear();
    state = [];
  }
}
