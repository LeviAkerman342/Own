import 'package:hive_flutter/hive_flutter.dart';
import 'package:own/features/journal/data/models/user_model.dart';

class HiveStorage {
  static const String userBox = 'user_box';
  static const String appBox = 'app_settings';

  static Future<void> init() async {
    await Hive.initFlutter();
    // Hive.registerAdapter(UserModelAdapter());
    await Hive.openBox<UserModel>(userBox);
    await Hive.openBox(appBox);
    await Hive.openBox('usersBox');
    await Hive.openBox('authBox');
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

  static Future<void> saveRegisteredUser(String email, String password) async {
    final box = Hive.box('usersBox');
    await box.put(email, password);
  }

  static Future<void> setUserEmail(String email) async {
    final box = Hive.box('authBox');
    await box.put('email', email);
  }

  static Future<void> setUserPassword(String password) async {
    final box = Hive.box('authBox');
    await box.put('password', password);
  }

  static Future<bool> checkUserExists(String email) async {
    final box = Hive.box('usersBox');
    return box.containsKey(email);
  }

  static Future<bool> validateUser(String email, String password) async {
    final box = Hive.box('usersBox');
    final storedPassword = box.get(email);
    return storedPassword == password;
  }

  static Future<void> logout() async {
    final box = Hive.box(appBox);
    await box.put('isLoggedIn', false);
  }

  static Future<void> setUserName(String name) async {
    final box = await Hive.openBox('authBox');
    await box.put('name', name);
  }

  static String? getUserName() {
    final box = Hive.box('authBox');
    return box.get('name');
  }

  static Future<void> setUserPhoto(String path) async {
    final box = await Hive.openBox('authBox');
    await box.put('photo', path);
  }

  static String? getUserPhoto() {
    final box = Hive.box('authBox');
    return box.get('photo');
  }
}
