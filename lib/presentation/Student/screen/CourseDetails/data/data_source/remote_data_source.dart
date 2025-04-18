


import 'package:edu_platt/core/constant/constant.dart';
import 'package:edu_platt/core/network/api_service.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/data/network/request/course_card_request.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/data/network/request/doctor_courses_request.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/data/network/request/fetch_file_request.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/data/network/response/course_card_response.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/data/network/response/doctor_courses_response.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/data/network/response/fetch_file_response.dart';

abstract class CourseDetailsRemoteDataSource {
  Future<FetchFileResponse> fetchCourseFiles(FetchFileRequest request);
  Future<CourseCardResponse> fetchCourseDetails(CourseCardRequest request);
  Future<DoctorCoursesResponse> fetchDoctorCourses(DoctorCoursesRequest request);
}

class CourseDetailsRemoteDataSourceImpl extends CourseDetailsRemoteDataSource {
  final ApiService apiService;

  CourseDetailsRemoteDataSourceImpl(this.apiService);

  @override
  Future<FetchFileResponse> fetchCourseFiles(FetchFileRequest request) async{
    /// TODO: implement video endpoint like this
    ///final endpoint = request.type == 'Videos' ? '' : '';
    var response = await  apiService.getFromUrl(endPoint: '${ApiConstants.baseUrl}/api/Materials/getDoctorMaterials/${request.courseCode}/${request.doctorId}/${request.type}');
    return FetchFileResponse.fromJson(response.data);
  }
  @override
  Future<CourseCardResponse> fetchCourseDetails(CourseCardRequest request) async{
    var response = await  apiService.getFromUrl(endPoint: '${ApiConstants.baseUrl}/api/Course/Details/${request.courseCode}/${request.doctorId}');
    return CourseCardResponse.fromJson(response.data);
  }

  @override
  Future<DoctorCoursesResponse> fetchDoctorCourses(DoctorCoursesRequest request) async{
    var response = await  apiService.getFromUrl(endPoint: '${ApiConstants.baseUrl}/api/Course/Details/${request.courseCode}');
    return DoctorCoursesResponse.fromJson(response.data);
  }


}
