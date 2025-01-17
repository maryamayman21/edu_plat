import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import 'package:edu_platt/presentation/Auth/service/token_service.dart';
import 'package:meta/meta.dart';

import '../../../../../core/cashe/services/notes_cache_service.dart';
import '../../../../../core/network_handler/network_handler.dart';
import '../data/model/note.dart';
import '../data/notes_repository/notes_repository.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  final NotesRepository notesRepository;
  final TokenService tokenService;
  final NotesCacheService notesCacheService;

  NotesCubit({
    required this.notesRepository,
    required this.tokenService,
    required this.notesCacheService
  }) : super(NotesInitial());


  Future<void> saveNote(Note note) async {
    try {
      //cache note
      //update server
      final token = await tokenService.getToken();

      final noteID = await notesRepository.saveNote(note, token!);
      //response contains note id

      List<Note> notes = await notesCacheService.saveNote(note, noteID);
      print("Note cached successfully");
      print('SAVED  NOTES :  $notes');
      emit(NotesSuccess(notes));
      // if (responseData['success'] == true) {
      //   final message = responseData['message'] ?? 'Registration successful.';
      //   emit(NotesSuccess(message));
      // } else {
      //   emit(NotesFailure('Registration failed'));
      // }
    } catch (error) {
      if (!isClosed) {
        if (error is DioError && error.response != null) {
          // Handle specific API errors
          final errorMessage =
              error.response?.data['message'] ?? 'An unexpected error occurred';
          emit(NotesFailure(errorMessage));
        } else {
          emit(NotesFailure(
              NetworkHandler.mapErrorToMessage(error)));
        }
      }
    }
  }

  Future<void> updateNote(bool isDone, int id) async {
    try {
      //cache note
      //update server
      final token = await tokenService.getToken();

      final response = await notesRepository.updateNote(isDone, id, token!);

      final responseData = response.data;
      if (responseData['success'] == true) {
        final message = responseData['message'] ?? 'Note updated successfully.';
        print(message);
      } else {
        print('Note update failed');
      }

      List<Note> updatedList = await notesCacheService.updateNote(id, isDone);
      print("Note updated in cache  successfully");
      if (updatedList.isNotEmpty && updatedList != null) {
        emit(NotesSuccess(updatedList));
      }
      else {
        emit(NotesFailure('Failed to update notes'));
      }
    } catch (error) {
      if (!isClosed) {
        if (error is DioError && error.response != null) {
          // Handle specific API errors
          final errorMessage =
              error.response?.data['message'] ?? 'An unexpected error occurred';
          emit(NotesFailure(errorMessage));
        } else {
          emit(NotesFailure(
              NetworkHandler.mapErrorToMessage(error)));
        }
      }
    }
  }

  Future<void> deleteNote(int noteID) async {
    try {
      final token = await tokenService.getToken();

      final response = await notesRepository.deleteNotes(noteID, token!);
      final responseData = response.data;
      if (responseData['success'] == true) {
        final message = responseData['message'] ?? 'Note deleted successfully.';
        print(message);
      } else {
        print('Note deletion failed');
      }

      List<Note> updatedList = await notesCacheService.deleteNoteById(noteID);
      print("Note deleted in cache  successfully");
      if (updatedList.isNotEmpty && updatedList != null) {
        emit(NotesSuccess(updatedList));
      }
      else {
        emit(NotesNotFound());
      }
    } catch (error) {
      if (!isClosed) {
        if (error is DioError && error.response != null) {
          // Handle specific API errors
          // final errorMessage =
          //     error.response?.data['message'] ?? 'An unexpected error occurred';
          emit(NotesFailure(error.message));
        } else {
          emit(NotesFailure(
              NetworkHandler.mapErrorToMessage(error)));
        }
      }
    }
  }

  Future<void> getAllNotes() async {
    try {
      // if (!isClosed) {
      print('get all is called');
      emit(NotesLoading());
      //}
      //try cache
      print('get all is called again');
      final cachedNotes = await notesCacheService.getNotes();
      if (cachedNotes != null && cachedNotes.isNotEmpty) {
        print('Got from cache notes : $cachedNotes');
        emit(NotesSuccess(cachedNotes));
        return;
      }
      print('Trying fetching notes from server');
      final token = await tokenService.getToken();
      List<Note> notes = await notesRepository.getAllNotes(token!);
      if (notes != null && notes.isNotEmpty) {
        await notesCacheService.saveNotesList(notes);

        if (!isClosed) {
          emit(NotesSuccess(notes));
        }
      } else {
        if (!isClosed) {
          emit(NotesNotFound());
        }
      }
    } catch (error) {
      if (!isClosed) {
        if (error is DioError && error.response != null) {
          // Handle specific API errors
          final errorMessage =
              error.response?.data['message'] ?? 'An unexpected error occurred';
          emit(NotesFailure(errorMessage));
        } else {
          emit(NotesFailure(NetworkHandler.mapErrorToMessage(error)));
        }
      }
    }
  }

  Future<void> deleteAllCachedNotes() async {
    await notesCacheService.clearNotesCache();
    print("Notes deleted in cache  successfully");
  }
}