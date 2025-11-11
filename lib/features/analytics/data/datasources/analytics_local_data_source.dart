import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entities/analytics_entity.dart';

class AnalyticsLocalDataSource {
  static const _analyticsBox = 'analytics_box';

  Future<void> init() async {
    if (!Hive.isBoxOpen(_analyticsBox)) {
      await Hive.openBox(_analyticsBox);
    }
  }

  Future<void> saveAnalytics(AnalyticsEntity data) async {
    final box = Hive.box(_analyticsBox);
    await box.put('analytics', {
      'totalAmount': data.totalAmount,
      'categories': data.categories,
      'transactions': data.transactions
          .map((t) => {
                'name': t.name,
                'amount': t.amount,
                'category': t.category,
                'imageUrl': t.imageUrl,
              })
          .toList(),
    });
  }

  AnalyticsEntity getAnalytics() {
    final box = Hive.box(_analyticsBox);
    final data = box.get('analytics');
    if (data == null) {
      return AnalyticsEntity(totalAmount: 0, categories: {}, transactions: []);
    }
    return AnalyticsEntity(
      totalAmount: data['totalAmount'],
      categories: Map<String, double>.from(data['categories']),
      transactions: (data['transactions'] as List)
          .map((e) => TransactionEntity(
                name: e['name'],
                amount: e['amount'],
                category: e['category'],
                imageUrl: e['imageUrl'],
              ))
          .toList(),
    );
  }
}
