
import 'package:dio/dio.dart';
import 'package:edu_platt/presentation/Student/screen/notes/data/model/note.dart';
import 'package:edu_platt/presentation/Student/screen/notes/data/notes_web_service/notes_web_service.dart';



class NotesRepository {
  final  NotesWebService notesWebService;

  NotesRepository(this.notesWebService);
  Future<Response> deleteNotes(int nodeID, String token) async {
    return await notesWebService.deleteNote(nodeID, token);
  }
  Future<int> saveNote(Note note, String token) async {
     final response   = await notesWebService.saveNote(note, token);
     return  response.data['itemId'];

  }
  Future<Response> updateNote(bool isDone, int id,String token) async {
    return await notesWebService.updateNote(isDone, id,token);
  }
  Future<List<Note>> getAllNotes(String token) async {
    final response = await notesWebService.getAllNotes(token);

    // Ensure the response data is a list and parse each item to a Note
    final List<dynamic> notesJson = response.data;
    return notesJson.map((noteJson) => Note.fromJson(noteJson)).toList();
  }
  // Future<List<Note>> getNotesByDate(DateTime date) async {
  //   final response = await notesWebService.getAllNotes(token);
  //
  //   // Ensure the response data is a list and parse each item to a Note
  //   final List<dynamic> notesJson = response.data;
  //   return notesJson.map((noteJson) => Note.fromJson(noteJson)).toList();
  // }

}