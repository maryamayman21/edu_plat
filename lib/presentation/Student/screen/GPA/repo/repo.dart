import 'package:dio/dio.dart';
import 'package:edu_platt/core/constant/constant.dart';
import 'package:edu_platt/presentation/Student/screen/GPA/model/model.dart';

class GPARepository {
  final Dio dio = Dio();
  final String getGpaUrl = '${ApiConstants.baseUrl}/api/GPA/GetGPA';
  final String updateGpaUrl = '${ApiConstants.baseUrl}/api/GPA/UpdateGPA';

  Future<GpaModel> fetchGpa(String token) async {
    try {
      final response = await dio.get(
        getGpaUrl,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return GpaModel.fromJson(response.data);
    }on DioException catch (e) {
      // Dio-specific error
      final msg = e.response?.data['message'] ??"Check your internet connection or try again later." ;
      throw Exception(msg);
    } catch (e) {
      // Generic error
      throw Exception('Check your internet connection or try again later.');
    }
  }

  Future<GpaModel> updateGpa(double  gpa, String token) async {
   print('UPDTAE GPA IN SERVER');
    try {
      final response = await dio.post(
        updateGpaUrl,
        data: {"gpa": gpa},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return GpaModel(gpa: gpa);
      }else {
        final errorMsg = response.data['message'] ?? "Check your internet connection or try again later.";
        throw Exception(errorMsg);
      }
    } on DioException catch (e) {
      final msg = e.response?.data['message'] ??"Check your internet connection or try again later.";
      throw Exception(msg);
    } catch (e) {
      throw Exception("Check your internet connection or try again later.");
    }
  }
}