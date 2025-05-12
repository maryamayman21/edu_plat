import 'package:edu_platt/core/constant/constant.dart';
import 'package:edu_platt/core/network/api_service.dart';
import 'package:edu_platt/core/utils/helper_methds/get_user_type.dart';
import 'package:edu_platt/presentation/courses/data/network/requests/delete_course_request.dart';
import 'package:edu_platt/presentation/courses/data/network/response/delete_course_response.dart';
import 'package:edu_platt/presentation/courses/data/network/response/fetch_request_response.dart';

abstract class CoursesRemoteDateSource{
Future<FetchCoursesResponse>  fetchCourses();
Future <DeleteCourseResponse> deleteCourse(DeleteCourseRequest request);
}


class CourseRemoteDataSourceImpl implements CoursesRemoteDateSource{
  final ApiService apiService;
  CourseRemoteDataSourceImpl(this.apiService);

  @override
  Future<FetchCoursesResponse> fetchCourses()async{
    final String? userType = await getUserType();
    final String endPoint = userType == 'Student' ?  ApiConstants.studentCoursesEndPoint : ApiConstants.getCoursesEndPoint;


    var response = await  apiService.getFromUrl(endPoint:endPoint);
    return FetchCoursesResponse.fromJson(response.data);
  }
  @override
  Future<DeleteCourseResponse> deleteCourse(DeleteCourseRequest request)async {
    final String? userType = await getUserType();
    final String endPoint = userType == 'Student' ? ApiConstants.studentdeleteCourseEndPoint :  ApiConstants.deleteCourseEndPoint;
    var response = await  apiService.delete(endPoint:endPoint,  data:  request.toJson());
    return DeleteCourseResponse.fromJson(response.data);
  }
}