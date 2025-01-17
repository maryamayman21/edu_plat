

import 'package:dio/dio.dart';

import '../data_source/course_web_service.dart';

class CourseRepository {
  final CourseWebService courseWebService;

  CourseRepository(this.courseWebService);
  Future<Response> deleteCourse(String courseCode, String token) async {
    return await courseWebService.deleteCourse(courseCode, token);
  }
  Future<Response> getCourses( String token) async {
    print('Courses in repo Done');
    final response=  await courseWebService.getCourses( token);
    print('Courses in repo  response: ${response.data}');
  // final List<String>? courses =  response.data;
    //print('Courses in repo : $courses');
    return response;
  }
}