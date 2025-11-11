import 'package:hive_flutter/hive_flutter.dart';
import 'package:own/features/analytics/data/models/transaction_model.dart';

class TransactionHiveService {
  static const String boxName = 'transactions_box';

  static Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      // Hive.registerAdapter(TransactionModelAdapter());
    }
    await Hive.openBox<TransactionModel>(boxName);
  }

  static Box<TransactionModel> getBox() => Hive.box<TransactionModel>(boxName);

  static List<TransactionModel> getAll() {
    final box = getBox();
    return box.values.toList();
  }

  static Future<void> add(TransactionModel transaction) async {
    final box = getBox();
    await box.add(transaction);
  }

  static Future<void> clear() async {
    final box = getBox();
    await box.clear();
  }
}
