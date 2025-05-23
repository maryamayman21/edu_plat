import 'package:dio/dio.dart';
import 'package:edu_platt/core/constant/constant.dart';
import 'package:edu_platt/presentation/Student/screen/Private_chat/Conversation/doctorModel/modelDoctor.dart';

class ChatRepository {
  final Dio dio = Dio();
  final String baseUrl = ApiConstants.baseUrl;

  Future<List<DoctorModel>> getDoctors(String token) async {
    final response = await dio.get(
      "$baseUrl${ApiConstants.getDoctorsForStudentEndpoint}",
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;

      return data.map((json) => DoctorModel.fromJson(json as Map<String, dynamic>)).toList();
    } else {
      throw Exception("Failed to load doctors");
    }
  }
}