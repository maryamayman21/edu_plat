import 'dart:convert';
import 'package:dio/dio.dart';

import '../data_source/web_service.dart';
import '../models/course.dart';

class CourseRegistrationRepository {
  final CourseRegistrationWebService courseRegistrationWebService;

  CourseRegistrationRepository(this.courseRegistrationWebService);
  Future<Response> fetchRegistrationCourses(int semesterID, String token) async {
      print("Done in repo 1");
      return await courseRegistrationWebService.fetchRegistrationCourses(semesterID, token);
  }
  Future<Response> registerCourses(List<String> courses, String token) async {
    print("Done in repo 1");
    return await courseRegistrationWebService.registerCourses(courses, token);
  }
}