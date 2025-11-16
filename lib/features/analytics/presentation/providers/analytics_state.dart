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
