// lib/features/room/presentation/widgets/room_member_card.dart
import 'package:flutter/material.dart';
import 'package:own/features/rooms/domain/entities/room_entity.dart';

class RoomMemberCard extends StatelessWidget {
  final RoomMember member;

  const RoomMemberCard({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color(0xFF5E7CFF).withOpacity(0.2),
        child: Text(
          member.name.isNotEmpty ? member.name[0].toUpperCase() : "?",
          style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF5E7CFF)),
        ),
      ),
      title: Text(member.name, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text("Потрачено: ${member.totalSpent.toStringAsFixed(0)} ₽"),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
    );
  }
}