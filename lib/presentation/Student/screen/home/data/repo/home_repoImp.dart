import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:edu_platt/core/network/failure.dart';
import 'package:edu_platt/core/network/internet_connection_service.dart';
import 'package:edu_platt/presentation/Student/screen/home/data/remote_data_source/remote_data_source.dart';
import 'package:edu_platt/presentation/Student/screen/home/data/request/student_help_file_request.dart';
import 'package:edu_platt/presentation/Student/screen/home/data/response/student_help_file_response.dart';
import 'package:edu_platt/presentation/Student/screen/home/domain/entity/file_entity.dart';
import 'package:edu_platt/presentation/Student/screen/home/domain/repo/home_repo.dart';

class HomeRepoImp implements HomeRepo{
  final HomeRemoteDataSource homeRemoteDataSource;
  final NetworkInfo _networkInfo;
  HomeRepoImp(this.homeRemoteDataSource, this._networkInfo);


  @override
  Future<Either<Failure, List<FileEntity>>> fetchFile(
      StudentHelpFileRequest request) async {
    if (await _networkInfo.isConnected) {
      try {
        StudentFileHelpResponse response = await homeRemoteDataSource
            .fetchFile(request);
        if (response.status == true) {
          return right(response.fileModel);
        }
        return left(ServerFailure(   response.message ??   'Something went wrong'));
        //return right([CourseFileEntity(name: 'Lecture 1', path: 'ss', size: '10KB', extension:'png', date:'10-2-2024')]);
      } catch (e) {
        if (e is DioError) {
          return left(ServerFailure.fromDiorError(e));
        }
        return left(ServerFailure(e.toString()));
      }
    } else {
      return left(ServerFailure('No internet connection'));
    }

  }
}