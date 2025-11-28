import 'package:flutter_riverpod/legacy.dart';
import 'package:own/core/storage/transaction_hive.dart';
import 'package:own/features/analytics/data/models/analytics_filter.dart';
import 'package:own/features/analytics/data/models/transaction_model.dart';

class AnalyticsState {
  final List<TransactionModel> transactions;
  final AnalyticsFilter filter;
  final bool isLoading;

  AnalyticsState({
    required this.transactions,
    required this.filter,
    required this.isLoading,
  });

  AnalyticsState copyWith({
    List<TransactionModel>? transactions,
    AnalyticsFilter? filter,
    bool? isLoading,
  }) {
    return AnalyticsState(
      transactions: transactions ?? this.transactions,
      filter: filter ?? this.filter,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AnalyticsNotifier extends StateNotifier<AnalyticsState> {
  AnalyticsNotifier()
    : super(
        AnalyticsState(
          transactions: [],
          filter: AnalyticsFilter.month,
          isLoading: true,
        ),
      ) {
    _load();
  }

  Future<void> _load() async {
    await Future.delayed(const Duration(milliseconds: 600)); // для skeleton
    final data = TransactionHiveService.getAll();
    state = state.copyWith(transactions: data, isLoading: false);
  }

  void changeFilter(AnalyticsFilter filter) {
    state = state.copyWith(filter: filter);
  }
}

final analyticsProvider =
    StateNotifierProvider<AnalyticsNotifier, AnalyticsState>((ref) {
      return AnalyticsNotifier();
    });
