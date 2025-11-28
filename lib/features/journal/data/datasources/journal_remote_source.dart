import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../models/user_model.dart';

class JournalRemoteSource {
  final DioClient dioClient;

  JournalRemoteSource(this.dioClient);

  Future<List<UserModel>> fetchUsers() async {
    try {
      final Response res = await dioClient.get('/users');
      final List<dynamic> data = res.data;
      return data.map((json) => UserModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Ошибка при загрузке данных: $e');
    }
  }
}
