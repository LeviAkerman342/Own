import 'package:flutter_riverpod/legacy.dart';
import '../../data/models/user_model.dart';

final usersProvider = StateProvider<List<UserModel>>((ref) {
  return [
    
    const UserModel(
      name: 'Мама',
      role: 'Главный кошелёк',
      avatarUrl: 'https://example.com/mama.jpg',
      balance: 12700,
    ),
    const UserModel(
      name: 'Папа',
      role: 'Дополнительный счёт',
      avatarUrl: 'https://example.com/papa.jpg',
      balance: 26000,
    ),
    const UserModel(
      name: 'Пёрсик',
      role: 'Доча',
      avatarUrl: 'https://example.com/persik.jpg',
      balance: 0,
    ),
  ];

});
