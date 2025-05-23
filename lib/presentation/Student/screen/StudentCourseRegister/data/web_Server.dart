import 'package:dio/dio.dart';
import 'package:edu_platt/core/constant/constant.dart';



class StudentCourseRegistrationWebService {
  late Dio _dio;

  StudentCourseRegistrationWebService() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
    ));
  }

  Future<Response> fetchRegistrationCourses(int semesterID, String token) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.courseRegistrationEndPoint}$semesterID',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      print('Register response: ${response.data}'); // Debug print
      return response;
    } catch (e) {
      print('Fetching courses error : ${e.toString()}');
      rethrow;
    }

  }
  Future<Response> registerCourses(List<String> courses ,  String token) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.studentregisterCoursesEndPoint}',
        data: {
          "coursesCodes": courses
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      print('Register response: ${response.data}'); // Debug print
      return response;
    } catch (e) {
      print('Fetching courses error : ${e.toString()}');
      rethrow;
    }
  }


}
