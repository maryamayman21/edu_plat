
import 'package:edu_platt/core/constant/constant.dart';
import 'package:edu_platt/core/network/api_service.dart';
import 'package:edu_platt/presentation/Student/screen/home/data/request/student_help_file_request.dart';
import 'package:edu_platt/presentation/Student/screen/home/data/response/student_help_file_response.dart';

abstract class HomeRemoteDataSource {
  Future<StudentFileHelpResponse> fetchFile( StudentHelpFileRequest request);
}


class HomeRemoteDataSourceImp implements  HomeRemoteDataSource{
  final ApiService apiService;

  HomeRemoteDataSourceImp({required this.apiService});
  @override
  Future<StudentFileHelpResponse> fetchFile(StudentHelpFileRequest request) async{
    var response = await  apiService.getFromUrl(endPoint: '${ApiConstants.baseUrl}${ApiConstants.studentHelpFiles}${request.type}');
    return StudentFileHelpResponse.fromJson(response.data);
  }
}