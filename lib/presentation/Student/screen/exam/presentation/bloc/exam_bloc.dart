import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/cubit/dialog_cubit.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/exam_model.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/question_model.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/model/student_exam_model.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/model/submit_exam_model.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/network/request/fetch_exam_questions_request.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/network/request/fetch_exams_request.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/network/request/start_exam_request.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/network/request/submit_exam_request.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/repo/exam_repoImp.dart';
import 'package:edu_platt/presentation/Student/screen/exam/domain/entity/exam_card_entity.dart';
import 'package:equatable/equatable.dart';


part 'exam_event.dart';
part 'exam_state.dart';

class ExamBloc extends Bloc<ExamEvent, ExamState> {
  StudentExamRepoImp studentExamRepoImp;
  final DialogCubit dialogCubit;
 // List<StudentExamCardEntity>? _examCards;
  //final Map<String, Timer> _timers = {};
  //Timer? _timer;
  //DateTime? _examStartTime;
  ExamBloc( {required this.studentExamRepoImp, required this.dialogCubit}) : super(ExamInitial()) {
    on<FetchExamsEvent>((event, emit) async {
      emit(ExamLoading());
      final result = await studentExamRepoImp.fetchExams(
         FetchExamsRequest(isFinishedExam: event.isExamtaken));
      result.fold((failure) {
        emit(ExamError(failure.message));
      }, (exams) {
      //  _examCards = exams;
      //   for (var exam in _examCards!) {
      //     Future.delayed(Duration(seconds: 2), () {
      //       print("After 2 seconds");
      //     });
      //     _startTimerForExam(exam);
      //   }
        emit(ExamCardsLoaded(exams));
      });
    });

    ///TODO:: NO NEED FOR THIS
     on<FetchExamQuestions>((event, emit) async {
      emit(ExamLoading());
      final result = await studentExamRepoImp.fetchExamQuestions(
         FetchExamQuestionsRequest(doctorId: event.doctorId, courseCode: event.courseCode, examId: event.examId));
      result.fold((failure) {
        emit(ExamError(failure.message));
      }, (questions) {
        emit(ExamQuestionsLoaded(questions));
      });
    });

     on<SubmitExamScore>((event, emit) async {
      emit(ExamLoading());
      final result = await studentExamRepoImp.submitExam(
        SubmitExamRequest(exam:event.exam));
      result.fold((failure) {
        emit(ExamError(failure.message));
      }, (successMessage) {

        emit(ExamSuccess(successMessage));
      });
    });

     on<StartExamEvent>((event, emit) async {
      //emit(ExamLoading());
       dialogCubit.setStatus('Loading', message: 'Loading');
      final result = await studentExamRepoImp.startExam(
        StartExamRequest(examId: event.examId));
      result.fold((failure) {
        dialogCubit.setStatus('Failure', message: failure.message);
        //emit(ExamError(failure.message));
      }, (exam) {
        emit(ExamLoaded(exam));
      });
    });


   // // on<CheckExamStartTime>(_onCheckExamStartTime);
   //  on<UpdateExamStartTime>(_onUpdateExamStartTime);

  }


  // void _startTimerForExam(StudentExamCardEntity exam) {
  //   final currentTime = DateTime.now();
  //   final timeDifference = exam.date.difference(currentTime);
  //
  //   if (timeDifference.isNegative || timeDifference.inSeconds == 0) {
  //     // Exam has already started
  //    // emit(ExamLoading());
  //
  //     emit(ExamStarted( _examCards??[], exam.examId));
  //   } else {
  //     // Start a timer for the exam
  //
  //     print('Start timer for ${exam.examId}');
  //     _timers[exam.examId.toString()] = Timer(timeDifference, () {
  //       add(UpdateExamStartTime( exam.date, exam.examId));
  //     });
  //   }
  // }
  //
  // void _onUpdateExamStartTime(UpdateExamStartTime event, Emitter<ExamState> emit) {
  //   print('Before emitting ExamStartedStet  id : ${event.examId}');
  //
  //   emit(ExamStarted( _examCards??[], event.examId)); // Emit which exam has started
  // }

  @override
  Future<void> close() {
    // Cancel all timers when the bloc is closed
  //  _timers.forEach((examId, timer) => timer.cancel());
    return super.close();
  }
}
