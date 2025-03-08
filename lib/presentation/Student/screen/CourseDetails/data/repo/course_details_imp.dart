import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:edu_platt/core/network/failure.dart';
import 'package:edu_platt/core/network/internet_connection_service.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/data/data_source/remote_data_source.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/data/network/request/course_card_request.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/data/network/request/doctor_courses_request.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/data/network/request/fetch_file_request.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/data/network/response/course_card_response.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/data/network/response/doctor_courses_response.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/data/network/response/fetch_file_response.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/domain/entity/course_card_entity.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/domain/entity/course_file_entity.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/domain/entity/doctor_courses_entity.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/domain/repo/course_details_repo.dart';

class CourseDetailsRepoImp implements CourseDetailsRepo {
//  final CourseDetailsLocalDataSource courseDetailsLocalDataSource;
  final CourseDetailsRemoteDataSource courseDetailsRemoteDataSource;
  final NetworkInfo _networkInfo;

  CourseDetailsRepoImp(
      this.courseDetailsRemoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, List<CourseFileEntity>>> fetchCourseFiles(
      FetchFileRequest request) async {
    List<CourseFileEntity> coursesFiles;
   if (await _networkInfo.isConnected) {
     try {

        FetchFileResponse response = await courseDetailsRemoteDataSource
            .fetchCourseFiles(request);
        if (response.status == true) {
          return right(response.courses ?? []);
        }
        return left(ServerFailure('Something went wrong'));
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
  @override
  Future<Either<Failure, CourseCardEntity>> fetchCourseCard(CourseCardRequest request)async {
   // CourseFileEntity coursesFiles;
    if (await _networkInfo.isConnected) {
      try {

       CourseCardResponse response = await courseDetailsRemoteDataSource
            .fetchCourseDetails(request);
        if (response.status == true) {
          return right(response.courseCardEntity);
        }
        return left(ServerFailure('Something went wrong'));
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

  @override
  Future<Either<Failure, List<DoctorCoursesEntity>>> fetchDoctorCourses(DoctorCoursesRequest request)async {
    if (await _networkInfo.isConnected) {
      try {

        DoctorCoursesResponse response = await courseDetailsRemoteDataSource
            .fetchDoctorCourses(request);
        if (response.status == true) {
          return right(response.doctorCoursesEntity);
        }
        return left(ServerFailure('Something went wrong'));
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