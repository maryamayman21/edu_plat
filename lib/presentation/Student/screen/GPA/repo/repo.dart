import 'package:dio/dio.dart';
import 'package:edu_platt/presentation/Student/screen/GPA/model/model.dart';

class GPARepository {
  final Dio dio = Dio();
  final String getGpaUrl = 'https://great-hot-impala.ngrok-free.app/api/GPA/GetGPA';
  final String updateGpaUrl = 'https://great-hot-impala.ngrok-free.app/api/GPA/UpdateGPA';

  Future<GpaModel> fetchGpa(String token) async {
    try {
      final response = await dio.get(
        getGpaUrl,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return GpaModel.fromJson(response.data);
    } catch (e) {
      throw Exception("Failed to fetch GPA: $e");
    }
  }

  Future<GpaModel> updateGpa(double  gpa, String token) async {
    try {
      final response = await dio.post(
        updateGpaUrl,
        data: {"gpa": gpa},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return GpaModel(gpa: gpa);
      } else {
        throw Exception("Failed to update GPA: ${response.data['message']}");
      }
    } catch (e) {
      throw Exception(" Error updating GPA: $e");
    }
  }
}