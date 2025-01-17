import '../../../presentation/Student/screen/notes/data/model/note.dart';
import '../base_cashe_service.dart';


class NotesCacheService {
  static final NotesCacheService _instance = NotesCacheService._internal();
  final BaseCacheService _baseCacheService = BaseCacheService();

  NotesCacheService._internal();

  factory NotesCacheService() => _instance;

  /// Save a new note or update the existing list of notes
  /// Save a new note or update the existing list of notes
  Future<List<Note>> saveNote(Note note, int id) async {
    // Fetch existing cached notes
    final cachedNotes = await getNotes() ?? <Note>[];

    // Check if the note with the given ID already exists
    final index = cachedNotes.indexWhere((n) => n.id == id);

    // Update the note's ID with the provided ID
    final updatedNote = Note(
      id: id,
      title: note.title,
      description: note.description,
      isDone: note.isDone,
      date: note.date,
    );

    if (index != -1) {
      // Update the existing note
      cachedNotes[index] = updatedNote;
    } else {
      // Add the new note with the updated ID
      cachedNotes.add(updatedNote);
    }

    // Save the updated list back to the cache
    final notesJson = cachedNotes.map((n) => n.toJson()).toList();
    await _baseCacheService.save('notes', notesJson);
    return cachedNotes;
  }


  Future<void> saveNotesList(List<Note> notes) async {
    // Convert the list of Note objects to JSON
    final notesJson = notes.map((note) => note.toJson()).toList();

    // Save the list of notes to the cache
    await _baseCacheService.save('notes', notesJson);
  }



  /// Get all cached notes
  Future<List<Note>?> getNotes() async {
    // Read and cast the cached notes to a list of Note objects
    final notesJson = await _baseCacheService.read('notes') as List<dynamic>?;
    return notesJson?.map((json) => Note.fromJson(json)).toList();
  }

  /// Delete a note by its ID
  Future<List<Note>> deleteNoteById(int id) async {
    // Fetch existing cached notes
    final cachedNotes = await getNotes() ?? <Note>[];

    // Remove the note with the specified ID
    cachedNotes.removeWhere((note) => note.id == id);

    // Save the updated list back to the cache
    final notesJson = cachedNotes.map((n) => n.toJson()).toList();
    await _baseCacheService.save('notes', notesJson);

    // Return the updated list of notes
    return cachedNotes;
  }


  /// Update a note's isDone status and other properties by ID
  Future<List<Note>> updateNote(int id, bool isDone) async {
    // Fetch existing cached notes
    final cachedNotes = await getNotes() ?? <Note>[];

    // Find the index of the note with the given ID
    final index = cachedNotes.indexWhere((note) => note.id == id);
    if (index != -1) {
      // Get the note and update its isDone property
      final updatedNote = cachedNotes[index].copyWith(isDone: isDone);

      // Replace the updated note in the cached list
      cachedNotes[index] = updatedNote;

      // Save the updated list back to the cache
      await  saveNotesList(cachedNotes);
      return cachedNotes;
    }
    return [];
  }

  /// Clear all cached notes
  Future<void> clearNotesCache() async {
    await _baseCacheService.delete('notes');
  }
}
