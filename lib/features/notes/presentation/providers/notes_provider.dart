import 'package:flutter_riverpod/legacy.dart';
import 'package:own/features/notes/data/datasources/notes_local_data_source.dart';
import '../../domain/entities/note_entity.dart';
import '../../domain/usecases/add_note_usecase.dart';
import '../../data/repositories/notes_repository_impl.dart';
import '../../data/models/note_model.dart';
import 'package:hive/hive.dart';

final notesProvider = StateNotifierProvider<NotesNotifier, List<NoteEntity>>((
  ref,
) {
  final box = Hive.box<NoteModel>('notesBox');
  final dataSource = NotesLocalDataSource(box);
  final repo = NotesRepositoryImpl(dataSource);
  final usecase = AddNoteUseCase(repo);
  return NotesNotifier(usecase, repo);
});

class NotesNotifier extends StateNotifier<List<NoteEntity>> {
  final AddNoteUseCase addNoteUseCase;
  final NotesRepositoryImpl repo;

  NotesNotifier(this.addNoteUseCase, this.repo) : super(repo.getNotes());

  Future<void> addNote(NoteEntity note) async {
    await addNoteUseCase(note);
    state = repo.getNotes();
  }

  Future<void> clearNotes() async {
    await repo.clearNotes();
    state = [];
  }
}
