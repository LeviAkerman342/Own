import 'package:hive_flutter/hive_flutter.dart';
import 'package:own/features/journal/data/models/user_model.dart';
import 'package:own/features/journal/data/models/user_model.g.dart';

class HiveStorage {
  static const String userBox = 'user_box';
  static const String appBox = 'app_settings';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    await Hive.openBox<UserModel>(userBox);
    await Hive.openBox(appBox);
  }

  // ------------------ USERS ------------------
  static Future<void> saveUsers(List<UserModel> users) async {
    final box = Hive.box<UserModel>(userBox);
    await box.clear();
    for (var user in users) {
      await box.add(user);
    }
  }

  static List<UserModel> getUsers() {
    final box = Hive.box<UserModel>(userBox);
    return box.values.toList();
  }

  // ------------------ APP SETTINGS ------------------
  static bool isFirstLaunch() {
    final box = Hive.box(appBox);
    return box.get('isFirstLaunch', defaultValue: true);
  }

  static Future<void> setFirstLaunchFalse() async {
    final box = Hive.box(appBox);
    await box.put('isFirstLaunch', false);
  }

  static bool isLoggedIn() {
    final box = Hive.box(appBox);
    return box.get('isLoggedIn', defaultValue: false);
  }

  static Future<void> setLoggedIn(bool value) async {
    final box = Hive.box(appBox);
    await box.put('isLoggedIn', value);
  }
}
