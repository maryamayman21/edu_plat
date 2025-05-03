import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:edu_platt/core/cashe/services/questions_cashe_service.dart';
import 'package:edu_platt/core/network/failure.dart';
import 'package:edu_platt/core/network/internet_connection_service.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/option_model.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/question_model.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/exam_item_widgets/online_exam_card.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/data_source/remote_data_source.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/network/request/fetch_exam_questions_request.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/network/request/fetch_exams_request.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/network/request/start_exam_request.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/network/request/submit_exam_request.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/network/response/fetch_exams_response.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/network/response/start_exam_response.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/network/response/submit_exam_response.dart';
import 'package:edu_platt/presentation/Student/screen/exam/domain/entity/exam_card_entity.dart';
import 'package:edu_platt/presentation/Student/screen/exam/domain/repo/exam_repo.dart';

class StudentExamRepoImp implements  StudentExamRepo {
  final StudentExamsRemoteDataSource studentExamsRemoteDataSource;
  final NetworkInfo _networkInfo;

  StudentExamRepoImp(this.studentExamsRemoteDataSource, this._networkInfo);




  @override
  Future<Either<Failure, List<StudentExamCardEntity>>> fetchExams(FetchExamsRequest request)async {
    if (await _networkInfo.isConnected) {
      try {
        final  FetchExamsResponse response = await studentExamsRemoteDataSource.fetchExams(request);
        // List<StudentExamCardEntity> finishedExamCards = [
        //   StudentExamCardEntity(examTitle: 'Quiz1', courseCode: 'COMP202', date: DateTime.now(), duration: 15, isExamFinished: true, doctorId: 1, examId: 2, isOnline: false, totalMark: 30, location: 'offline', questionNumbers: 4, attended: true, percentage: 60, score: 25),
        //   StudentExamCardEntity(examTitle: 'Quiz2', courseCode: 'COMP202', date: DateTime.now(), duration: 15, isExamFinished: true, doctorId: 1, examId: 2, isOnline: true, totalMark: 30, location: 'offline', questionNumbers: 4, attended: true, percentage: 60, score: 25),
        //
        // ];List<StudentExamCardEntity> notFinishedExamCards = [
        //   StudentExamCardEntity(examTitle: 'Quiz3', courseCode: 'COMP202', date: DateTime.parse('2025-04-24T11:19:10-00:00'), duration: 15, isExamFinished: false, doctorId: 1, examId: 1, isOnline: true, totalMark: 30, location: 'offline', questionNumbers: 4, attended: false, percentage: 0, score: 0),
        //   StudentExamCardEntity(examTitle: 'Quiz4', courseCode: 'COMP202', date: DateTime.parse('2025-04-24T11:25:20-00:00'), duration: 15, isExamFinished: false, doctorId: 1, examId: 2, isOnline: true, totalMark: 30, location: 'offline', questionNumbers: 4, attended: false, percentage: 0, score: 0),
        //   StudentExamCardEntity(examTitle: 'Quiz4', courseCode: 'COMP202', date: DateTime.parse('2025-04-24T11:25:20-00:00'), duration: 15, isExamFinished: false, doctorId: 1, examId: 2, isOnline: true, totalMark: 30, location: 'offline', questionNumbers: 4, attended: false,  percentage: 0, score: 0),
        //
        // ];
        if(response.status == true){
          return right(response.finishedExamCardEntity);
        }

        return left(ServerFailure(response.message ?? 'something went wrong'));

        // else{
        //   return left(ServerFailure(response.message ?? 'Something went wrong'));
        // }
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


///TODO:: NO NEED FOR THIS
  @override
  Future<Either<Failure, List<QuestionModel>>> fetchExamQuestions(FetchExamQuestionsRequest request)async {
    if (await _networkInfo.isConnected) {
      try {

          // Create a list of QuestionModel objects
          List<QuestionModel> questions = [
            QuestionModel(
              question: 'What is Flutter?',
              degree: 10,
              questionDuration: Duration(minutes: 5),
              options: [
                OptionModel(text: 'A programming language', isCorrectAnswer: false),
                OptionModel(text: 'A UI toolkit', isCorrectAnswer: true),
                OptionModel(text: 'A database', isCorrectAnswer: false),
              ],
              isValid: true,
            ),
            QuestionModel(
              question: 'What is Dart?',
              degree: 10,
              questionDuration: Duration(minutes: 5),
              options: [
                OptionModel(text: 'A programming language', isCorrectAnswer: true),
                OptionModel(text: 'A UI framework', isCorrectAnswer: false),
                OptionModel(text: 'A database', isCorrectAnswer: false),
              ],
              isValid: true,
            ),
            QuestionModel(
              question: 'What is the main purpose of Firebase?',
              degree: 15,
              questionDuration: Duration(minutes: 7),
              options: [
                OptionModel(text: 'Backend as a Service (BaaS)', isCorrectAnswer: true),
                OptionModel(text: 'Frontend framework', isCorrectAnswer: false),
                OptionModel(text: 'Programming language', isCorrectAnswer: false),
              ],
              isValid: true,
            ),
            QuestionModel(
              question: 'Which widget is used for layout in Flutter?',
              degree: 10,
              questionDuration: Duration(minutes: 5),
              options: [
                OptionModel(text: 'Container', isCorrectAnswer: true),
                OptionModel(text: 'Text', isCorrectAnswer: false),
                OptionModel(text: 'Icon', isCorrectAnswer: false),
              ],
              isValid: true,
            ),
          ];

        return right(questions);

        // else{
        //   return left(ServerFailure(response.message ?? 'Something went wrong'));
        // }
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
  Future<Either<Failure, dynamic>> startExam(StartExamRequest request) async {
  if (await _networkInfo.isConnected) {
    try {
             StartExamResponse response  = await studentExamsRemoteDataSource.startExam(request);
             if(response.status == true){
                return right(response.exam);
             }else {
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
  Future<Either<Failure, String>> submitExam(SubmitExamRequest request)async {
    if (await _networkInfo.isConnected) {
      try {
        SubmitExamResponse response  = await studentExamsRemoteDataSource.submitExam(request);
        if(response.status == true){
          await  QuestionsCacheService().clearAllQuestions();
          return right(response.message ?? 'Your response is submitted successfully');
        }else {
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