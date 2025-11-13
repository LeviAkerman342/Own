import 'package:hive/hive.dart';
import '../models/note_model.dart';

class NotesLocalDataSource {
  final Box<NoteModel> box;

  NotesLocalDataSource(this.box);

  Future<void> addNote(NoteModel note) async {
    await box.put(note.id, note);
  }

  List<NoteModel> getNotes() => box.values.toList();

  Future<void> clearNotes() async => box.clear();
}
