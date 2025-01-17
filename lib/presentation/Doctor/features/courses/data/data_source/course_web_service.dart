import 'package:dio/dio.dart';

import '../../../../../../core/constant/constant.dart';

class CourseWebService {
  late Dio _dio;

  CourseWebService() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 10)
    ));
  }

  Future<Response> deleteCourse(String courseCode, String token) async {
    try {
      final response = await _dio.delete(
        ApiConstants.deleteCourseEndPoint,
        data:{
          "courseCode" : courseCode
        } ,

        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      print('Delete course response: ${response.data}'); // Debug print
      return response;
    } catch (e) {
      print('Delete course error : ${e.toString()}');
      rethrow;
    }

  }

  Future<Response> getCourses(String token) async {
    try {
      final response = await _dio.get(
        ApiConstants.getCoursesEndPoint,

        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      print('Get course response: ${response.data}'); // Debug print
      return response;
    } catch (e) {
      print('Get course error : ${e.toString()}');
      rethrow;
    }
  }

}
