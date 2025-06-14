import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:edu_platt/core/network/failure.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/cubit/dialog_cubit.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/network/request/delete_exam_request.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/network/request/getExamsRequest.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/network/request/student_degrees_request.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/repo/exam_repository_impl.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/domain/entity/exam_entity.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/domain/entity/student_degree_entity.dart';
import 'package:equatable/equatable.dart';


part 'exam_event.dart';
part 'exam_state.dart';

class ExamBloc extends Bloc<ExamEvent, ExamState> {
  DoctorExamRepoImp doctorExamRepoImp;
  final DialogCubit dialogCubit;
  ExamBloc({required this.doctorExamRepoImp, required this.dialogCubit}) : super(ExamInitial()) {
    on<FetchExamsEvent>((event, emit) async {
      emit(ExamLoading());
      final result = await doctorExamRepoImp.getDoctorExams(
          GetExamsRequest(isExamTaken: event.isExamtaken));
      result.fold((failure) {
        if(failure.message == 'No internet connection') {
          emit(ExamsNoWifi());
        }
        else{
          emit(ExamError(failure.message));
        }

      }, (exams) {
        if (exams.isEmpty) {
          emit(ExamsIsEmpty());
        }
        else {
          emit(ExamLoaded(exams));
        }
      });
    });

    on<GetStudentDegrees>((event, emit) async {
      emit(ExamLoading());
      final result = await doctorExamRepoImp.getStudentDegrees(
          StudentDegreesRequest(examId: event.examId));
      result.fold((failure) {
        emit(ExamError(failure.message));
      }, (studentDegrees) {
        emit(StudentDegreesLoaded(studentDegrees: studentDegrees));
      });
    });


  //   on<DeleteExam>((event, emit) async {
  //     // Step 1: Delete the exam
  //     dialogCubit.setStatus('Loading');
  //
  //     final deleteResult = await doctorExamRepoImp.deleteExam(
  //       DeleteExamRequest(examId: event.id),
  //     );
  //
  //     // Handle the result of the delete operation
  //     if (deleteResult.isLeft()) {
  //       // Emit an error state if the delete operation fails
  //       dialogCubit.setStatus('Failure', message:'Failed to delete file, try again' );
  //       return;
  //     }
  //
  //     // Step 2: Fetch updated exams after successful deletion
  //     final fetchResult = await doctorExamRepoImp.getDoctorExams(
  //       GetExamsRequest(isExamTaken: event.isExamtaken),
  //     );
  //
  //     // Handle the result of the fetch operation
  //     fetchResult.fold(
  //           (failure) {
  //         dialogCubit.setStatus('Failure', message: failure.message);
  //       },
  //           (exams) {
  //             dialogCubit.setStatus('Success');
  //             if (exams.isEmpty) {
  //               emit(ExamsIsEmpty());
  //             }
  //             else {
  //               emit(ExamLoaded(exams));
  //             }
  //           }
  //     );
  //   });
  // }

  on<DeleteExam>((event, emit) async {
      // Step 1: Delete the exam
      dialogCubit.setStatus('Loading');
    //   final results = await Future.wait([
    //   doctorExamRepoImp.deleteExam(
    //   DeleteExamRequest(examId: event.id),
    // ),
    //     doctorExamRepoImp.getDoctorExams(
    //       GetExamsRequest(isExamTaken: event.isExamtaken),
    //     ) // Adjust the call as needed
    //   ]);
    //   final Either<Failure, String> deleteExamResult = results[0] as Either<Failure, String>;
    //   final Either<Failure, List<ExamEntity>> getExamResult = results[1] as Either<Failure, List<ExamEntity>>;
    //
    //
    //   deleteExamResult.fold(
    //         (failure) {
    //           dialogCubit.setStatus('Failure', message:failure.message );
    //     },
    //         (successMessage) {
    //       // Now handle the registered courses result
    //           getExamResult.fold(
    //             (failure) {
    //               dialogCubit.setStatus('Failure', message: failure.message);
    //         },
    //             (exams) {
    //               dialogCubit.setStatus('Success', message: successMessage);
    //               if (exams.isEmpty) {
    //                 print('HEE');
    //                 emit(ExamsIsEmpty());
    //               }
    //               else {
    //                 print('HELL NO');
    //                 emit(ExamLoaded(exams));
    //               }
    //         },
    //       );
    //     },
    //   );
    //






      final deleteResult = await doctorExamRepoImp.deleteExam(
        DeleteExamRequest(examId: event.id),
      );

      if (deleteResult.isLeft()) {
        // Emit an error state if the delete operation fails


        final error = deleteResult.fold(
              (failure) => failure.message,  // Extract Failure object
              (success) => null,     // Not needed here since we checked isLeft()
        );
        dialogCubit.setStatus('Failure', message:error?? 'Failed to delete' );
        return;
      }
      if (deleteResult.isRight()) {
        // Emit an error state if the delete operation fails


        final success = deleteResult.fold(
              (failure) => null,  // Extract Failure object
              (success) => success,     // Not needed here since we checked isLeft()
        );

        final fetchResult = await doctorExamRepoImp.getDoctorExams(
          GetExamsRequest(isExamTaken: event.isExamtaken),
        );


        fetchResult.fold(
                (failure) {
              dialogCubit.setStatus('Failure', message: failure.message);
            },
                (exams) {
                  dialogCubit.setStatus('Success', message:success?? 'Exam deleted successfully' );

                  if (exams.isEmpty) {
                emit(ExamsIsEmpty());
              }
              else {
                emit(ExamLoaded(exams));
              }
            }
        );


      }


    });
      }

}
