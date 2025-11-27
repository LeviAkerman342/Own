import 'package:equatable/equatable.dart';
import '../../domain/entities/room_entity.dart';

abstract class RoomState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RoomLoading extends RoomState {}

class RoomLoaded extends RoomState {
  final List<RoomMember> members;
  final List<SharedTransaction> transactions;
  final Map<String, double> balance;
  final int memberCount;
  final int maxMembers;

  final String roomDescription;
  final String inviteCode;

  RoomLoaded({
    required this.members,
    required this.transactions,
    required this.balance,
    required this.memberCount,
    required this.maxMembers,
    required this.roomDescription,
    required this.inviteCode,
  });

  @override
  List<Object?> get props => [
    members,
    transactions,
    balance,
    memberCount,
    maxMembers,
    roomDescription,
    inviteCode,
  ];
}
