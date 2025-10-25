import 'package:hive_flutter/hive_flutter.dart';
import 'package:own/features/journal/data/models/user_model.dart';

class HiveStorage {
  static const String userBox = 'user_box';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    await Hive.openBox<UserModel>(userBox);
  }

  static Future<void> saveUsers(List<UserModel> users) async {
    final box = Hive.box<UserModel>(userBox);
    await box.clear();
    for (var u in users) {
      await box.add(u);
    }
  }

  static List<UserModel> getUsers() {
    final box = Hive.box<UserModel>(userBox);
    return box.values.toList();
  }
}
