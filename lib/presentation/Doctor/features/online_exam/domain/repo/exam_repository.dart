


import 'package:dartz/dartz.dart';
import 'package:edu_platt/core/network/failure.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/exam_model.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/network/request/create_exam_request.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/network/request/delete_exam_request.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/network/request/fetch_course_data.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/network/request/getExamsRequest.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/network/request/model_answer_request.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/network/request/student_degrees_request.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/network/request/update_exam_request.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/network/request/update_offline_exam_request.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/network/request/update_online_exam_request.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/domain/entity/course_data_entity.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/domain/entity/exam_entity.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/domain/entity/model_answer.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/domain/entity/student_degree_entity.dart';

abstract class DoctorExamRepo {
  Future<Either<Failure, String>> createExam(
      CreateExamRequest request);
  Future<Either<Failure, String>> updateExam(
      UpdateExamRequest request);
  Future<Either<Failure, List<ExamEntity>>> getDoctorExams(
      GetExamsRequest request);
  Future<Either<Failure, String>> deleteExam(
       DeleteExamRequest request);
  Future<Either<Failure, List<ModelAnswerEntity>>> getModelAnswer(
      ModelAnswerRequest request);
  Future<Either<Failure, OnlineExamModel>> getOnlineExam(
      UpdateOnlineExamRequest request
      );
  Future<Either<Failure, OfflineExamModel>> getOfflineExam(
      UpdateOfflineExamRequest request
      );
 Future<Either<Failure, List<StudentDegreeEntity>>> getStudentDegrees(
    StudentDegreesRequest request
      );
  Future<Either<Failure, List<String>>> fetchCourses();
  Future<Either<Failure, CourseDataEntity>> fetchCourseData(FetchCourseDataRequest request);
}