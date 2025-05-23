import 'package:dio/dio.dart';
import 'package:edu_platt/core/constant/constant.dart';
import 'package:edu_platt/presentation/Doctor/screen/chat/ConversationDoctor/StudentModel/model.dart';

class DoctorChatRepository {
  final Dio dio = Dio();
  final String baseUrl = ApiConstants.baseUrl;

  Future<List<StudentModel>> getStudents(String token) async {
    final response = await dio.get(
      "$baseUrl${ApiConstants.getStudentsForDoctorEndpoint}",
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