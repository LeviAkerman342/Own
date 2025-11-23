import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/room_entity.dart';

class RoomCubit extends Cubit<RoomState> {
  RoomCubit() : super(RoomLoading()) {
    _loadRoom();
  }

  Future<void> _loadRoom() async {
    await Future.delayed(const Duration(milliseconds: 600));

    final members = [
      const RoomMember(id: "1", name: "Мама", totalSpent: 12450),
      const RoomMember(id: "2", name: "Папа", totalSpent: 8900),
      const RoomMember(id: "3", name: "Ты", totalSpent: 5600),
    ];

    final transactions = [
      SharedTransaction(
        id: "t1",
        payerName: "Мама",
        amount: 2500,
        category: "Продукты",
        date: DateTime.now().subtract(const Duration(hours: 3)),
        comment: "Пятерочка",
      ),
      SharedTransaction(
        id: "t2",
        payerName: "Ты",
        amount: 1200,
        category: "Транспорт",
        date: DateTime.now().subtract(const Duration(days: 1)),
        comment: "Яндекс.Такси",
      ),
    ];

    emit(RoomLoaded(members: members, transactions: transactions));
  }

  void inviteViaContacts() {
    // Здесь будет contacts_permission + share link
    print("Запрос доступа к контактам...");
  }

  void copyInviteLink() {
    // flutter_clipboard_manager или share_plus
    print("Ссылка скопирована: own.app/join/room/abc123");
  }
}

abstract class RoomState {}

class RoomLoading extends RoomState {}

class RoomLoaded extends RoomState {
  final List<RoomMember> members;
  final List<SharedTransaction> transactions;
  RoomLoaded({required this.members, required this.transactions});
}
