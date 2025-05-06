import 'package:dio/dio.dart';

import '../../../../../../core/constant/constant.dart';
import '../model/note.dart';

class NotesWebService {
  late Dio _dio;

 NotesWebService() {
    _dio = Dio(BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10)
    ));
  }

  Future<Response> deleteNote(int noteID, String token) async {
    try {
      final response = await _dio.delete(
        '${ApiConstants.deleteNoteEndPoint}$noteID',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      print('Delete note response: ${response.data}'); // Debug print
      return response;
    } catch (e) {
      print('Delete note error : ${e.toString()}');
      rethrow;
    }

  }
  Future<Response> saveNote(Note note, String token) async {
    try {
      final response = await _dio.post(
        ApiConstants.addNoteEndPoint,
        data:note.toJson(), ///TODO::TEST
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      print('Save note response: ${response.data}'); // Debug print
      return response;
    } catch (e) {
      print('Save note error : ${e.toString()}');
      rethrow;
    }

  }
  Future<Response> updateNote(bool isDone, int noteID ,String token) async {
    try {
      final response = await _dio.put(
        '${ApiConstants.updateNoteEndPoint}$noteID',
        data:{
          "IsDone" : isDone
        } ,

        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      print('Update note response: ${response.data}'); // Debug print
      return response;
    } catch (e) {
      print('Update note error : ${e.toString()}');
      rethrow;
    }

  }

  Future<Response> getAllNotes(String token) async {
    try {
      final response = await _dio.get(
        ApiConstants.getAllNotesEndPoint,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      print('Get all notes response: ${response.data}'); // Debug print
      return response;
    } catch (e) {
      print('Get all notes error : ${e.toString()}');
      rethrow;
    }

  }
  Future<Response> getNotesByDate(String token, DateTime date) async {
    try {
      final response = await _dio.get(
        ApiConstants.getAllNotesEndPoint,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      print('Get all notes response: ${response.data}'); // Debug print
      return response;
    } catch (e) {
      rethrow;
    }

  }

}
