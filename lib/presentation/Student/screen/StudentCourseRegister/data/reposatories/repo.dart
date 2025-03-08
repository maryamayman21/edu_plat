import 'package:dio/dio.dart';
import 'package:edu_platt/presentation/Student/screen/StudentCourseRegister/data/web_Server.dart';

class StudentCourseRegistrationRepository {
  final StudentCourseRegistrationWebService studentcourseRegistrationWebService;

  StudentCourseRegistrationRepository(this.studentcourseRegistrationWebService);
  Future<Response> fetchRegistrationCourses(int semesterID, String token) async {
    print("Done in repo 1");
    return await studentcourseRegistrationWebService.fetchRegistrationCourses(semesterID, token);
  }
  Future<Response> registerCourses(List<String> courses, String token) async {
    print("Done in repo 1");
    return await studentcourseRegistrationWebService.registerCourses(courses, token);
  }
}

