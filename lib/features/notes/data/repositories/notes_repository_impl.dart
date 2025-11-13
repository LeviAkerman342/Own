import 'package:own/features/notes/data/datasources/notes_local_data_source.dart';

import '../../domain/entities/note_entity.dart';
import '../../domain/repositories/notes_repository.dart';
import '../models/note_model.dart';

class NotesRepositoryImpl implements NotesRepository {
  final NotesLocalDataSource localDataSource;

  NotesRepositoryImpl(this.localDataSource);

  @override
  Future<void> addNote(NoteEntity note) async {
    final model = NoteModel.fromEntity(note);
    await localDataSource.addNote(model);
  }

  @override
  List<NoteEntity> getNotes() => localDataSource.getNotes();

  @override
  Future<void> clearNotes() async => localDataSource.clearNotes();
}
