// import 'package:flutter/material.dart';

// class MemberSpentList extends StatelessWidget {
//   final List<MemberStat> members;

//   const MemberSpentList({super.key, required this.members});

//   @override
//   Widget build(BuildContext context) {
//     if (members.isEmpty) {
//       return Padding(
//         padding: const EdgeInsets.only(top: 20),
//         child: Column(
//           children: [
//             Icon(Icons.hourglass_empty, size: 40, color: Colors.grey.shade400),
//             const SizedBox(height: 12),
//             Text("Нет данных",
//                 style: TextStyle(color: Colors.grey.shade600)),
//           ],
//         ),
//       );
//     }

//     return Column(
//       children: members.map((e) {
//         return Container(
//           margin: const EdgeInsets.only(bottom: 12),
//           padding: const EdgeInsets.all(14),
//           decoration: BoxDecoration(
//             color: const Color(0xffF9FAFB),
//             borderRadius: BorderRadius.circular(14),
//           ),
//           child: Row(
//             children: [
//               CircleAvatar(radius: 20, backgroundImage: NetworkImage(e.avatar)),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Text(e.name,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 15,
//                     )),
//               ),
//               Text(
//                 "${e.amount > 0 ? '+' : ''}${e.amount.toStringAsFixed(0)} MDL",
//                 style: TextStyle(
//                   color: e.amount >= 0 ? Colors.green : Colors.red,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         );
//       }).toList(),
//     );
//   }
// }
