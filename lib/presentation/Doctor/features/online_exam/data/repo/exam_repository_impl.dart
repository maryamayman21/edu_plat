import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:edu_platt/core/network/failure.dart';
import 'package:edu_platt/core/network/internet_connection_service.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/exam_model.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/option_model.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/question_model.dart';
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
import 'package:edu_platt/presentation/Doctor/features/online_exam/domain/entity/course_data_entity.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/domain/entity/exam_entity.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/domain/entity/model_answer.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/domain/entity/student_degree_entity.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/domain/repo/exam_repository.dart';
import 'package:edu_platt/presentation/courses/data/network/response/fetch_request_response.dart';

class DoctorExamRepoImp implements DoctorExamRepo {
  final DoctorExamsRemoteDataSource doctorExamsRemoteDataSource;
  final NetworkInfo _networkInfo;

  DoctorExamRepoImp(this.doctorExamsRemoteDataSource, this._networkInfo);
  @override
  Future<Either<Failure, List<String>>> fetchCourses()async {
    if (await _networkInfo.isConnected) {
      try {
        FetchCoursesResponse response =
        await doctorExamsRemoteDataSource.fetchCourses();
        if (response.status == true) {
          return right(response.courses.map((course) => course.courseCode).toList());
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
  Future<Either<Failure, String>> createExam(CreateExamRequest request) async {
    if (await _networkInfo.isConnected) {
      try {
        CreateExamResponse response =
            await doctorExamsRemoteDataSource.createExam(request);
        if (response.status == true) {
          return right(response.message ?? 'Exam created successfully');
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
  Future<Either<Failure, String>> updateExam(UpdateExamRequest request) async {
    if (await _networkInfo.isConnected) {
      try {
       UpdateExamResponse response =
            await doctorExamsRemoteDataSource.updateExam(request);
        if (response.status == true) {
          return right(response.message ?? 'Exam updated successfully');
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
  Future<Either<Failure, List<ExamEntity>>> getDoctorExams(
      GetExamsRequest request) async {
    if (await _networkInfo.isConnected) {
      try {
         GetExamsResponse response = await doctorExamsRemoteDataSource.getDoctorExams(request);

          if(response.status == true){
            return right(
               // request.isExamTaken ? takenExamEntities : notTakenExamEntities);
                   response.examEntity
            );
          }

        // List<ExamEntity> takenExamEntities = [
        //   ExamEntity('Quiz 1', 'COMP103', DateTime.now(), 10, true, 2, 1, true,
        //       30, 'online', 3),
        //   ExamEntity('Quiz 2', 'COMP103', DateTime.now(), 10, true, 2, 1, false,
        //       30, 'online', 3),
        // ];
        // List<ExamEntity> notTakenExamEntities = [
        //   ExamEntity('Quiz 3', 'COMP103', DateTime.now(), 10, false, 2, 1, true,
        //       30, 'offline', 4),
        //   ExamEntity('Quiz 4', 'COMP103', DateTime.now(), 10, false, 2, 1,
        //       false, 30, 'offline', 4)
        // ];

        else{
          return left(ServerFailure(response.message ?? 'Something went wrong'));
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
  Future<Either<Failure, String>> deleteExam(DeleteExamRequest request) async {
    if (await _networkInfo.isConnected) {
      try {
        DeleteExamResponse response =
            await doctorExamsRemoteDataSource.deleteExam(request);
        if (response.status == true) {
          return right(response.message ?? 'Exam deleted successfully');
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
  Future<Either<Failure, List<ModelAnswerEntity>>> getModelAnswer(
      ModelAnswerRequest request) async {
    if (await _networkInfo.isConnected) {
      try {
        ModelAnswerResponse response =
            await doctorExamsRemoteDataSource.getModelAnswer(request);
        if (response.status == true) {
          return right(response.modelAnswerEntity);
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
  Future<Either<Failure, OnlineExamModel>> getOnlineExam(
      UpdateOnlineExamRequest request) async {
    if (await _networkInfo.isConnected) {
      try {
        UpdateOnlineExamResponse response = await doctorExamsRemoteDataSource.getOnlineExam(request);
         if (response.status == true) {
           return right(response.exam);
         }
         else{
           return left(ServerFailure(response.message ?? 'Something went wrong'));
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
  Future<Either<Failure, OfflineExamModel>> getOfflineExam(
      UpdateOfflineExamRequest request) async {
    if (await _networkInfo.isConnected) {
      try {
        UpdateOfflineExamResponse response = await doctorExamsRemoteDataSource.getOfflineExam(request);
         if (response.status == true) {
           return right(response.exam);
         }
         else{
           return left(ServerFailure(response.message ?? 'Something went wrong'));
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
  Future<Either<Failure, List<StudentDegreeEntity>>> getStudentDegrees(
      StudentDegreesRequest request) async {
    if (await _networkInfo.isConnected) {
      try {
        StudentDegreesResponse response = await doctorExamsRemoteDataSource.getStudentDegrees(request);
         if (response.status == true) {
           return right(response.studentDegreeEntity);
         }
         else{
           return left(ServerFailure(response.message ?? 'Something went wrong'));
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
  Future<Either<Failure, CourseDataEntity>> fetchCourseData(FetchCourseDataRequest request)async {
    if (await _networkInfo.isConnected) {
      try {
        FetchCourseDataResponse response = await doctorExamsRemoteDataSource.fetchCourseData(request);
        if (response.status == true) {
          return right(response.courseDataModel);
        }
        else{
          return left(ServerFailure(response.message ?? 'Something went wrong'));
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
