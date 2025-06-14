
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:edu_platt/core/network/failure.dart';
import 'package:edu_platt/core/network/internet_connection_service.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/data/data_source/courses_details_local_data_source.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/data/data_source/remote_data_source.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/domain/entities/course_details_entity.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/domain/repos/course_details_repo.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/network/requests/course_details_requests/delete_file_request.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/network/requests/course_details_requests/download_file_request.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/network/requests/course_details_requests/fetch_file_request.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/network/requests/course_details_requests/update_file_request.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/network/requests/course_details_requests/upload_file_request.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/network/responses/delete_file_response.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/network/responses/fetch_files_response.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/network/responses/update_file_response.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/network/responses/upload_file_response.dart';
import 'package:path_provider/path_provider.dart';



class CourseDetailsRepoImp implements CourseDetailsRepo {
 final  CourseDetailsLocalDataSource courseDetailsLocalDataSource;
  final CourseDetailsRemoteDataSource courseDetailsRemoteDataSource;
  final NetworkInfo _networkInfo;
  CourseDetailsRepoImp(this.courseDetailsLocalDataSource, this.courseDetailsRemoteDataSource, this._networkInfo);
  @override
  Future<Either<Failure, List<CourseDetailsEntity>>> fetchCourseFiles(FetchFileRequest request)async {
    List<CourseDetailsEntity> coursesFiles;
    if (await _networkInfo.isConnected) {
      try {
        coursesFiles = await courseDetailsLocalDataSource.fetchCourseFiles(request.type, request.courseCode);

        if(coursesFiles.isNotEmpty){

          return right(coursesFiles);
        }
        FetchFileResponse response = await courseDetailsRemoteDataSource.fetchCourseFiles(request);
        if(response.status == true){
          // coursesFiles = getCourses(response.data , type);
          if(response.courses!.isNotEmpty) {
            print(response.courses);

            coursesFiles =
            await  courseDetailsLocalDataSource.saveCourseFiles(response.courses!);
            return right(response.courses ?? []);
          }
          return right(response.courses ?? []);

        }

        //-->this case returns an empty list
        return left(ServerFailure(response.message?? 'Something went wrong.'));

      } catch (e) {
        if (e is DioError) {
          return left(ServerFailure.fromDiorError(e));
        }
        return left(ServerFailure(e.toString()));
      }
    }else{
      try{

        FetchFileResponse response = await courseDetailsRemoteDataSource.fetchCourseFiles(request);
        if(response.status == true){
          // coursesFiles = getCourses(response.data , type);
          if(response.courses!.isNotEmpty) {
            print(response.courses);

            coursesFiles =
            await  courseDetailsLocalDataSource.saveCourseFiles(response.courses!);

            return right(response.courses ?? []);
          }
          return right(response.courses ?? []);

        }
        return left(ServerFailure(response.message?? 'Something went wrong.'));
      }
      catch(e){
        return left(ServerFailure('No internet connection'));
      }
    }
   }
    @override
  Future<Either<Failure, List<CourseDetailsEntity>>> saveCoursesFiles(UploadFileRequest request)async{
      List<CourseDetailsEntity> coursesFiles;
    if (await _networkInfo.isConnected) {
        try {
          //TODO:: implement server call

          final UploadFileResponse response = await  courseDetailsRemoteDataSource.saveCourseFiles(request);
             print('Done here');
          if(response.status == true){
           List<CourseDetailsEntity> list = [];
           list.add(response.course);
            coursesFiles =
               await  courseDetailsLocalDataSource.saveCourseFiles(list);
              return right(coursesFiles);
          }
          return left(ServerFailure(response.message?? 'Something went wrong.'));

        } catch (e) {
          if (e is DioError) {
            return left(ServerFailure.fromDiorError(e));
          }
          return left(ServerFailure(e.toString()));
        }
      }else{
      return left(ServerFailure('No internet connection'));
      }

   }

@override
  Future<Either<Failure, List<CourseDetailsEntity>>> deleteCoursesFile(int index, String type, String courseCode) async{

  List<CourseDetailsEntity> coursesFiles;
  if (await _networkInfo.isConnected) {
    try {
        //get course id
      final int? id = await courseDetailsLocalDataSource.getCourseId(index, type, courseCode);
       DeleteFileResponse response = await courseDetailsRemoteDataSource.deleteCourseFile(DeleteFileRequest( id: id!));
        if(response.status== true){
         //delete from cache
        coursesFiles = await courseDetailsLocalDataSource.deleteCourseFiles(index, type, courseCode);
        return right(coursesFiles);
        }
       return left(ServerFailure(response.message?? 'Something went wrong.'));

    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }else{
    return left(ServerFailure('No internet connection'));
     }
  }

  @override
  Future<Either<Failure, List<CourseDetailsEntity>>> updateCoursesFile(int index, String type, File file , String courseCode)async {

    List<CourseDetailsEntity> coursesFiles;
    if (await _networkInfo.isConnected) {
      try {
           int? id = await  courseDetailsLocalDataSource.getCourseId(index, type, courseCode);
         print('id in repo $id');
        final  UpdateFileResponse response = await courseDetailsRemoteDataSource.updateCourseFile(UpdateFileRequest( id: id!, file: file, type: type));

           if(response.status == true){
             //update cache
             coursesFiles = await  courseDetailsLocalDataSource.updateCourseFile(index, response.course);
             return right(coursesFiles);
           }
           return left(ServerFailure(response.message?? 'Something went wrong.'));

      } catch (e) {
        if (e is DioError) {
          return left(ServerFailure.fromDiorError(e));
        }
        return left(ServerFailure(e.toString()));
      }
    }else{
      return left(ServerFailure('No internet connection'));

    }
  }

  @override
  Future<Either<Failure, File>> downloadFile(String filePath, String fileName ,  int index ) async{
    // TODO: implement downloadFile

    if (await _networkInfo.isConnected) {
      try {
        //getting file path from database
        //String? filePath = courseDetailsLocalDataSource.getCourseFilePath(index, type, courseCode);
         //String? fileName = courseDetailsLocalDataSource.getCourseFileName(index, type, courseCode);
        Directory tempDir = await getTemporaryDirectory(); // Or use getApplicationDocumentsDirectory()
        String saveFilePath = '${tempDir.path}/$fileName';
        File file = File(saveFilePath);
         if(await file.exists()){
           return right(file);
         }

        final  response = await courseDetailsRemoteDataSource.downloadFile(DownloadFileRequest(filePath: filePath!));
          //response contains file

         if(response.statusCode == 200) {
           await file.writeAsBytes(response.data);
           return right(file);
         }
        return left(ServerFailure('Business Error'));

      } catch (e) {
        if (e is DioError) {
          return left(ServerFailure.fromDiorError(e));
        }
        return left(ServerFailure(e.toString()));
      }
    }else{
      return left(ServerFailure('No internet connection'));

    }


    // list -> index , course code , type , fileName
    // get path from database
    // call remote data source
    // it returns file
    // need to cache it in persistent storage
    // returns a filePath
    // we need to check if this path exists ? returns the stored filePath -> to avoid multiple requests


    throw UnimplementedError();
  }

  // ///helper function
  // List<CourseDetailsEntity> getCourses(Map<String, dynamic> data, String type){
  // List<CourseDetailsEntity> courses = [];
  //  for(var courseMap in data[type]){
  //     courses.add(CourseDetailsEntity.fromJson(courseMap));
  //  }
  //  return courses;
  //
  // }

}



