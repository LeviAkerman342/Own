import '../entities/note_entity.dart';

abstract class NotesRepository {
  Future<void> addNote(NoteEntity note);
  List<NoteEntity> getNotes();
  Future<void> clearNotes();
}
