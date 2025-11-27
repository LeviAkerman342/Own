import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' show Random;
import '../../domain/entities/room_entity.dart';
import 'room_state.dart';

class RoomCubit extends Cubit<RoomState> {
  static const int maxMembers = 5;

  RoomCubit() : super(RoomLoading()) {
    _loadRoom();
  }

  Future<void> _loadRoom() async {
    await Future.delayed(const Duration(milliseconds: 800));

    final inviteCode = _generateInviteCode();
    const roomDescription = "Семейный бюджет";

    final members = [
      const RoomMember(id: "1", name: "Мама", totalSpent: 12450),
      const RoomMember(id: "2", name: "Папа", totalSpent: 8900),
      const RoomMember(id: "3", name: "Ты", totalSpent: 5600),
      const RoomMember(id: "4", name: "Сестра", totalSpent: 3200),
    ];

    final transactions = [
      SharedTransaction(
        id: "1",
        payerName: "Мама",
        amount: 2500,
        category: "Продукты",
        date: DateTime.now().subtract(const Duration(hours: 2)),
        comment: "Пятёрочка",
      ),
      SharedTransaction(
        id: "2",
        payerName: "Ты",
        amount: 1200,
        category: "Транспорт",
        date: DateTime.now().subtract(const Duration(days: 1)),
        comment: "Такси",
      ),
      SharedTransaction(
        id: "3",
        payerName: "Папа",
        amount: 5000,
        category: "Комуналка",
        date: DateTime.now().subtract(const Duration(days: 3)),
        comment: "Свет + интернет",
      ),
    ];

    final balance = _calculateBalance(members, transactions);

    emit(
      RoomLoaded(
        members: members,
        transactions: transactions,
        balance: balance,
        memberCount: members.length,
        maxMembers: maxMembers,
        roomDescription: roomDescription,
        inviteCode: inviteCode,
      ),
    );
  }

  String _generateInviteCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    final code = List.generate(
      12,
      (_) => chars[random.nextInt(chars.length)],
    ).join();
    return '${code.substring(0, 4)}-${code.substring(4, 8)}-${code.substring(8)}';
  }

  Map<String, double> _calculateBalance(
    List<RoomMember> members,
    List<SharedTransaction> transactions,
  ) {
    final totalSpent = transactions.fold<double>(0, (sum, t) => sum + t.amount);
    final avg = totalSpent / members.length;

    final Map<String, double> balance = {};
    for (var member in members) {
      balance[member.name] = member.totalSpent - avg;
    }
    return balance;
  }
}
