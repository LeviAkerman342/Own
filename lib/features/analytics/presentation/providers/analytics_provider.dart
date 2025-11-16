import 'package:flutter_riverpod/legacy.dart';
import 'package:own/core/storage/transaction_hive.dart';
import 'package:own/features/analytics/data/models/analytics_filter.dart';
import 'package:own/features/analytics/data/models/transaction_model.dart';
import 'package:own/features/analytics/presentation/providers/analytics_state.dart';

final analyticsProvider =
    StateNotifierProvider<AnalyticsNotifier, AnalyticsState>((ref) {
      return AnalyticsNotifier();
    });

class AnalyticsNotifier extends StateNotifier<AnalyticsState> {
  AnalyticsNotifier()
    : super(
        AnalyticsState(
          transactions: [],
          filter: AnalyticsFilter.day,
          isLoading: true,
        ),
      ) {
    _loadFromHive();
  }

  Future<void> _loadFromHive() async {
    state = state.copyWith(isLoading: true);

    final data = TransactionHiveService.getAll();

    state = state.copyWith(transactions: data, isLoading: false);
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    await TransactionHiveService.add(transaction);
    final data = TransactionHiveService.getAll();

    state = state.copyWith(transactions: data);
  }

  Future<void> clearTransactions() async {
    await TransactionHiveService.clear();
    state = state.copyWith(transactions: []);
  }

  void changeFilter(AnalyticsFilter filter) {
    state = state.copyWith(filter: filter);
  }
}
