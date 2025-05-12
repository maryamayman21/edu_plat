import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:edu_platt/core/network/failure.dart';
import 'package:edu_platt/core/network/internet_connection_service.dart';
import 'package:edu_platt/presentation/courses/data/data_source/remote_date_source.dart';
import 'package:edu_platt/presentation/courses/data/network/requests/delete_course_request.dart';
import 'package:edu_platt/presentation/courses/data/network/response/delete_course_response.dart';
import 'package:edu_platt/presentation/courses/data/network/response/fetch_request_response.dart';
import 'package:edu_platt/presentation/courses/domain/entity/course_entity.dart';
import 'package:edu_platt/presentation/courses/domain/repo/courses_repo.dart';

class CoursesRepoImpl implements CoursesRepo{
  final CoursesRemoteDateSource coursesRemoteDataSource;
  final NetworkInfo _networkInfo;

  CoursesRepoImpl({required this.coursesRemoteDataSource, required NetworkInfo networkInfo}) : _networkInfo = networkInfo;

 @override
  Future<Either<Failure, List<CourseEntity>>> fetchCourses()async {
   if (await _networkInfo.isConnected) {
     try {
       FetchCoursesResponse response =
           await coursesRemoteDataSource.fetchCourses();
       if (response.status == true) {
         return right(response.courses);
       } else {
         return left(
             ServerFailure(response.message ?? 'Something went wrong'));
       }
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
  Future<Either<Failure, String>> deleteCourse( DeleteCourseRequest request)async {
    if (await _networkInfo.isConnected) {
      try {
        DeleteCourseResponse response =
            await coursesRemoteDataSource.deleteCourse(request);
        if (response.status == true) {
          return right(response.message?? '${request.courseCode} has been deleted successfully');
        } else {
          return left(
              ServerFailure(response.message ?? 'Something went wrong'));
        }
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