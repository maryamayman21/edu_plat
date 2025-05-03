import 'package:dio/dio.dart';
import 'package:edu_platt/presentation/Doctor/screen/chat/ConversationDoctor/StudentModel/model.dart';

class DoctorChatRepository {
  final Dio dio = Dio();
  final String baseUrl = "https://great-hot-impala.ngrok-free.app/api/Chat";

  Future<List<StudentModel>> getStudents(String token) async {
    final response = await dio.get(
      "https://great-hot-impala.ngrok-free.app/api/Chat/GetStudentsForDoctor/students",
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;

      return data.map((json) => StudentModel.fromJson(json as Map<String, dynamic>)).toList();
    } else {
      throw Exception("Failed to load student");
    }
  }
}