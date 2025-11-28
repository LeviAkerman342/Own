import 'package:hive/hive.dart';
import 'package:own/features/transactions/data/models/note_model.dart';

class TransactionsLocalDataSource {
  static const String boxName = 'transactions';

  TransactionsLocalDataSource(Box<TransactionModel> box);

  Future<void> init() async {
    if (!Hive.isBoxOpen(boxName)) await Hive.openBox(boxName);
  }

  Future<List<TransactionModel>> getAll() async {
    final box = Hive.box(boxName);
    final List<TransactionModel> list = box.values
        .map((e) => TransactionModel.fromMap(Map<String, dynamic>.from(e)))
        .toList()
        .cast<TransactionModel>();
    // sort by date desc
    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  Future<void> add(TransactionModel t) async {
    final box = Hive.box(boxName);
    await box.put(t.id, t.toMap());
  }

  Future<void> update(TransactionModel t) async {
    final box = Hive.box(boxName);
    await box.put(t.id, t.toMap());
  }

  Future<void> delete(String id) async {
    final box = Hive.box(boxName);
    await box.delete(id);
  }

  Future<void> clear() async {
    final box = Hive.box(boxName);
    await box.clear();
  }
}
