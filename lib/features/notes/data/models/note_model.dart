import 'package:hive/hive.dart';
import '../../domain/entities/note_entity.dart';

part 'note_model.g.dart';

@HiveType(typeId: 1)
class NoteModel extends NoteEntity {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final String category;

  @HiveField(4)
  final String currency;

  @HiveField(5)
  final DateTime date;

  @HiveField(6)
  final String? imagePath;

  NoteModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.currency,
    required this.date,
    this.imagePath,
  }) : super(
          id: id,
          title: title,
          amount: amount,
          category: category,
          currency: currency,
          date: date,
          imagePath: imagePath,
        );

  factory NoteModel.fromEntity(NoteEntity entity) => NoteModel(
        id: entity.id,
        title: entity.title,
        amount: entity.amount,
        category: entity.category,
        currency: entity.currency,
        date: entity.date,
        imagePath: entity.imagePath,
      );
}
