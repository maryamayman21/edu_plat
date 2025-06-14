



import 'package:edu_platt/core/constant/constant.dart';
import 'package:edu_platt/core/network/api_service.dart';
import 'package:edu_platt/core/utils/helper_methds/get_user_type.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/network/request/create_exam_request.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/network/request/delete_exam_request.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/network/request/fetch_course_data.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/network/request/getExamsRequest.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/network/request/model_answer_request.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/network/request/student_degrees_request.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/network/request/update_exam_request.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/network/request/update_offline_exam_request.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/network/request/update_online_exam_request.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/network/response/class%20FetchCourseDataResponse.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/network/response/create_exam_response.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/network/response/delete_exam_response.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/network/response/getExamsResponse.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/network/response/model_answer_response.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/network/response/student_degrees_response.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/network/response/update_exam_response.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/network/response/update_offline_exam_response.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/network/response/update_online_exam_response.dart';
import 'package:edu_platt/presentation/courses/data/network/response/fetch_request_response.dart';


abstract class DoctorExamsRemoteDataSource {
  Future<CreateExamResponse> createExam( CreateExamRequest request);
  Future<GetExamsResponse> getDoctorExams(GetExamsRequest request);
  Future<DeleteExamResponse> deleteExam(DeleteExamRequest request);
  Future<ModelAnswerResponse> getModelAnswer(ModelAnswerRequest request);
  Future<UpdateOnlineExamResponse> getOnlineExam( UpdateOnlineExamRequest request);
  Future<UpdateOfflineExamResponse> getOfflineExam( UpdateOfflineExamRequest request);
  Future<StudentDegreesResponse> getStudentDegrees( StudentDegreesRequest request);
  Future<UpdateExamResponse> updateExam( UpdateExamRequest request);
  Future<FetchCoursesResponse>  fetchCourses();
  Future<FetchCourseDataResponse>  fetchCourseData(FetchCourseDataRequest request);

}

class DoctorExamsRemoteDataSourceImpl extends DoctorExamsRemoteDataSource {
  final ApiService apiService;

  DoctorExamsRemoteDataSourceImpl(this.apiService);
  @override
  Future<FetchCoursesResponse> fetchCourses()async{
    var response = await  apiService.getFromUrl(endPoint:ApiConstants.getCoursesEndPoint);
    return FetchCoursesResponse.fromJson(response.data);
  }
  @override
  Future<CreateExamResponse> createExam(CreateExamRequest request) async {
    try {
      print('📤 Sending request to create exam...');
     print(request.toJson());
      final response = await apiService.post(
        endPoint: ApiConstants.doctorCreateExamEndpoint,
        data: request.toJson(),
      );

      print('✅ Request successful');
      print('create online exam response : ${response.data.toString()}');
      return CreateExamResponse.fromJson(response.data);
    } catch (e, stackTrace) {
      print('❌ Error while creating exam: $e');
      print('📌 StackTrace: $stackTrace');

      // Option 1: Throw custom error or rethrow
      throw Exception('Failed to create exam: $e');

      // Option 2: Return an error response if your model supports it
      // return CreateExamResponse.withError('Failed to create exam');
    }
  }


  @override
  Future<GetExamsResponse> getDoctorExams(GetExamsRequest request) async{
   var response = await apiService.get(endPoint: '${ApiConstants.baseUrl}${ApiConstants.doctorGetExamsEndpoint}=${request.isExamTaken}');
  print(response.data.toString());
   return GetExamsResponse.fromJson(response.data);
  }
   @override
  Future<DeleteExamResponse> deleteExam(DeleteExamRequest request) async{
     var response = await apiService.delete(endPoint: '${ApiConstants.baseUrl}${ApiConstants.doctorDeleteExamEndpoint}/${request.examId}');
     return DeleteExamResponse.fromJson(response.data);
  }


 @override
  Future<ModelAnswerResponse> getModelAnswer(ModelAnswerRequest request)async {
   var response = await apiService.get(
       endPoint: '${ApiConstants.baseUrl}/api/Exams/GetModelAnswer/${request
           .examId}');
   return ModelAnswerResponse.fromJson(response.data);
 }

 @override
  Future<UpdateOfflineExamResponse> getOfflineExam(UpdateOfflineExamRequest request) async{
   var response = await apiService.get(
       endPoint: '${ApiConstants.baseUrl}${ApiConstants.doctorGetExamEndpoint}${request
           .examId}');
   return UpdateOfflineExamResponse.fromJson(response.data);
  }
  @override
  Future<UpdateOnlineExamResponse> getOnlineExam(UpdateOnlineExamRequest request)async {
    var response = await apiService.get(
        endPoint: '${ApiConstants.baseUrl}${ApiConstants.doctorGetExamEndpoint}${request
            .examId}');
    return UpdateOnlineExamResponse.fromJson(response.data);
  }

  @override
  Future<StudentDegreesResponse> getStudentDegrees(StudentDegreesRequest request) async{
    var response = await apiService.get(
        endPoint: '${ApiConstants.baseUrl}${ApiConstants.getStudentDegreesEndpoint}${request
            .examId}');
    return StudentDegreesResponse.fromJson(response.data);
  }
  @override
  Future<UpdateExamResponse> updateExam(UpdateExamRequest request) async{
    try {
      print('📤 Sending request to create exam...');

      final response = await apiService.update(
        endPoint: '${ApiConstants.baseUrl}${ApiConstants.doctorUpdateExamEndpoint}${request
            .examId}',
        data: request.toJson(),
      );

      print('✅ Request successful');
       print('Response body : ${response.data}');
      return UpdateExamResponse.fromJson(response.data);
    } catch (e, stackTrace) {
      print('❌ Error while creating exam: $e');
      print('📌 StackTrace: $stackTrace');

      // Option 1: Throw custom error or rethrow
      throw Exception('Failed to create exam: $e');

      // Option 2: Return an error response if your model supports it
      // return CreateExamResponse.withError('Failed to create exam');
    }
  }

  @override
  Future<FetchCourseDataResponse> fetchCourseData(FetchCourseDataRequest request)async {
    var response = await apiService.get(
        endPoint: '${ApiConstants.baseUrl}/api/Course/ExamDetails/${request
            .courseCode}');
    return FetchCourseDataResponse.fromJson(response.data);
  }
}