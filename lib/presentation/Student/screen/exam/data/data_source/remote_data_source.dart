
import 'package:edu_platt/core/constant/constant.dart';
import 'package:edu_platt/core/network/api_service.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/network/request/fetch_exam_questions_request.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/network/request/fetch_exams_request.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/network/request/start_exam_request.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/network/request/submit_exam_request.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/network/response/fetch_exam_questions_response.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/network/response/fetch_exams_response.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/network/response/start_exam_response.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/network/response/submit_exam_response.dart';

abstract class StudentExamsRemoteDataSource {
  Future<FetchExamsResponse> fetchExams( FetchExamsRequest request);
  Future<FetchExamQuestionsResponse> fetchExamQuestions( FetchExamQuestionsRequest request);
  Future<SubmitExamResponse> submitExam( SubmitExamRequest request);
 Future<StartExamResponse> startExam( StartExamRequest request);


}

class StudentExamsRemoteDataSourceImpl extends StudentExamsRemoteDataSource {
  final ApiService apiService;

  StudentExamsRemoteDataSourceImpl(this.apiService);


  @override
  Future<FetchExamsResponse> fetchExams(FetchExamsRequest request)async {
    var response = await apiService.get(endPoint: '${ApiConstants.baseUrl}${ApiConstants.doctorGetExamsEndpoint}=${request.isFinishedExam}');
    return FetchExamsResponse.fromJson(response.data);
  }
  @override
  Future<FetchExamQuestionsResponse> fetchExamQuestions(FetchExamQuestionsRequest request) {
    // TODO: implement fetchExamQuestions
    throw UnimplementedError();
  }
  @override
  Future<SubmitExamResponse> submitExam(SubmitExamRequest request)async {
    var response = await apiService.post(endPoint: '${ApiConstants.baseUrl}${ApiConstants.studentSubmitExamEndpoint}', data: request.exam.toJson());
     print(response.data);
    return SubmitExamResponse.fromJson(response.data);
  }
  @override
  Future<StartExamResponse> startExam(StartExamRequest request) async{
    var response = await apiService.get(endPoint: '${ApiConstants.baseUrl}${ApiConstants.studentStartExamEndpoint}${request.examId}');
    return StartExamResponse.fromJson(response.data);
  }
}