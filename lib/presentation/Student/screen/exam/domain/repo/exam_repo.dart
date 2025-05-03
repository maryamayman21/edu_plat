
import 'package:dartz/dartz.dart';
import 'package:edu_platt/core/network/failure.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/question_model.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/network/request/fetch_exam_questions_request.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/network/request/fetch_exams_request.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/network/request/start_exam_request.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/network/request/submit_exam_request.dart';
import 'package:edu_platt/presentation/Student/screen/exam/domain/entity/exam_card_entity.dart';

abstract class StudentExamRepo {
  Future<Either<Failure, List<StudentExamCardEntity>>> fetchExams(
     FetchExamsRequest request);
  Future<Either<Failure, List<QuestionModel>>> fetchExamQuestions(
      FetchExamQuestionsRequest request);
  Future<Either<Failure, String>> submitExam(
      SubmitExamRequest request);
  Future<Either<Failure, dynamic>> startExam(
    StartExamRequest request);

}