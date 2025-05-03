
import 'package:dio/dio.dart';
import 'package:edu_platt/core/constant/constant.dart';
import 'package:edu_platt/core/network/api_service.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/network/requests/course_details_requests/delete_file_request.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/network/requests/course_details_requests/download_file_request.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/network/requests/course_details_requests/fetch_file_request.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/network/requests/course_details_requests/update_file_request.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/network/requests/course_details_requests/upload_file_request.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/network/responses/delete_file_response.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/network/responses/fetch_files_response.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/network/responses/update_file_response.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/network/responses/upload_file_response.dart';


abstract class CourseDetailsRemoteDataSource {
  Future<FetchFileResponse> fetchCourseFiles(FetchFileRequest request);
  Future<UploadFileResponse> saveCourseFiles(UploadFileRequest request);
  Future<DeleteFileResponse> deleteCourseFile(DeleteFileRequest request);
  Future<UpdateFileResponse> updateCourseFile(UpdateFileRequest request);
  Future<Response> downloadFile(DownloadFileRequest request);

}

class CourseDetailsRemoteDataSourceImpl extends CourseDetailsRemoteDataSource {
  final ApiService apiService;

  CourseDetailsRemoteDataSourceImpl(this.apiService);

  @override
  Future<FetchFileResponse> fetchCourseFiles(FetchFileRequest request) async{
    print('printing from remote data source : ${request.type}');
    var response = await  apiService.getFromUrl(endPoint: 'https://great-hot-impala.ngrok-free.app/api/Materials/Get-Material-ByType/courseCode/typeFile?courseCode=${request.courseCode}&typeFile=${request.type}');
    return FetchFileResponse.fromJson(response.data , request.type);
  }
  @override
  Future<UploadFileResponse> saveCourseFiles(UploadFileRequest request)async{
    final endpoint = request.type == 'Videos' ? ApiConstants.uploadVideoEndpoint : ApiConstants.uploadFileEndpoint;
    var response = await  apiService.postFormData(endPoint: endpoint, formData:  request.type == 'Videos' ?    await request.toFormDataVideo() :  await request.toFormData());
    return UploadFileResponse.fromJson(response.data);
  }


  @override
  Future<UpdateFileResponse> updateCourseFile(UpdateFileRequest request) async{
    var response = await  apiService.putFormData(endPoint: ApiConstants.updateFileEndpoint,formData: await request.toFormData());
    return UpdateFileResponse.fromJson(response.data);
  }
  @override
  Future<DeleteFileResponse> deleteCourseFile(DeleteFileRequest request)async{
    var response = await  apiService.delete(endPoint: '${ApiConstants.deleteFileEndpoint}${request.id}');
    return DeleteFileResponse.fromJson(response.data);
  }

  @override
  Future<Response> downloadFile(DownloadFileRequest request)async {
    var response = await  apiService.get(endPoint: '', data: request.toJson());
    return response.data;
  }
}
