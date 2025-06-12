import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:edu_platt/core/network/failure.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/cubit/dialog_cubit.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/exam_model.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/network/request/create_exam_request.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/network/request/update_exam_request.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/network/request/update_offline_exam_request.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/repo/exam_repository_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'offline_exam_event.dart';
part 'offline_exam_state.dart';

class OfflineExamBloc extends Bloc<OfflineExamEvent, OfflineExamState> {
  final DoctorExamRepoImp doctorExamRepoImp;
  final DialogCubit dialogCubit;
  OfflineExamBloc(
  {
    required this.doctorExamRepoImp,
    required this.dialogCubit
}
      ) : super(OfflineExamState.initial()) {


      on<SetDateEvent>(_handleSetExamDateEvent);
      on<SetCourseCodeEvent>(_handleSetExamCourseCodeEvent);
      on<SetExamTitleEvent>(_handleSetExamTitleCodeEvent);
      on<SetLocationEvent>(_handleSetExamLocationEvent);
      on<SetDurationEvent>(_handleSetExamDurationEvent);
      on<SetTotalMarkEvent>(_handleSetExamTotalMarkEvent);
      on<CreateOfflineExam>(_handleCreateOfflineExamEvent);
      on<UpdateOfflineExam>(_handleUpdateOfflineExamEvent);
      on<UpdateDoctorOfflineExam>(_handleUpdateDoctorOfflineExamEvent);
      on<SetUpExamEvent>(_handleSetUpExamEvent);
      on<SetSuccessModeEvent>(_handleSetSuccessModeEvent);

  }
  void _handleSetUpExamEvent(
      SetUpExamEvent event,
      Emitter<OfflineExamState> emit,) async {
    emit(state.copyWith(isCoursesLoading: true)); // Set loading state
    final result = await  doctorExamRepoImp.fetchCourses();
    // emit(state.copyWith(isLoading: false));
    result.fold(
          (failure) {
        emit(state.copyWith(
            isCoursesLoading: false,
            isCoursesFailed: true,
            errorMessage: failure.message
        ));
      },
          (courses) {
        emit(state.copyWith(
          registeredCourses: courses,
          isCoursesSuccess: true,
          isCoursesLoading: false,
          isCoursesFailed: false,
        ));
      },
    );
  }

  void _handleSetExamDateEvent(
      SetDateEvent event, Emitter<OfflineExamState> emit) {
    emit(state.copyWith(offlineExamModel: state.offlineExamModel.copyWith(examDate: event.examDate)));
  }

  void _handleSetExamCourseCodeEvent(
      SetCourseCodeEvent event, Emitter<OfflineExamState> emit) {
    emit(state.copyWith(
        offlineExamModel: state.offlineExamModel.copyWith(courseCode: event.courseCode)));
  }

  void _handleSetExamTitleCodeEvent(
      SetExamTitleEvent event, Emitter<OfflineExamState> emit) {
    emit(state.copyWith(
        offlineExamModel: state.offlineExamModel.copyWith(examTitle: event.courseTitle)));
  }
  void _handleSetExamTotalMarkEvent(
      SetTotalMarkEvent event, Emitter<OfflineExamState> emit) {
    emit(state.copyWith(
        offlineExamModel: state.offlineExamModel.copyWith(totalMark: event.mark)));
  }
  void _handleSetExamDurationEvent(
      SetDurationEvent event, Emitter<OfflineExamState> emit) {
    emit(state.copyWith(
        offlineExamModel: state.offlineExamModel.copyWith(examDuration: event.examDuration)));
  }
  void _handleSetExamLocationEvent(
      SetLocationEvent event, Emitter<OfflineExamState> emit) {
    emit(state.copyWith(
        offlineExamModel: state.offlineExamModel.copyWith(location: event.examLocation)));
  }
  void _handleCreateOfflineExamEvent(
      CreateOfflineExam event, Emitter<OfflineExamState> emit) async{
    dialogCubit.setStatus('Loading');

    final result = await doctorExamRepoImp
        .createExam(CreateExamRequest(exam: state.offlineExamModel));

    result.fold((failure) {
      dialogCubit.setStatus('Failure', message: failure.message);
    }, (successMessage) {
      dialogCubit.setStatus('Success', message: successMessage);
      emit(state.copyWith(
          isSuccess: true
      ));
    });
  }





  void _handleUpdateOfflineExamEvent(
      UpdateOfflineExam event, Emitter<OfflineExamState> emit
      )
  async {
    emit(state.copyWith(isLoading: true)); // Show loading state

    try {
      // Run both requests in parallel
      final results = await Future.wait([
       doctorExamRepoImp.getOfflineExam(UpdateOfflineExamRequest(examId:event.examId )),
        doctorExamRepoImp.fetchCourses(), // Adjust the call as needed
      ]);

      final Either<Failure, OfflineExamModel> offlineExamResult = results[0] as Either<Failure, OfflineExamModel>;
      final Either<Failure, List<String>> registeredCoursesResult = results[1] as Either<Failure, List<String>>;

      // Handle online exam result
      offlineExamResult.fold(
            (failure) {
          emit(state.copyWith(
            isLoading: false,
            isFailure: true,
            errorMessage: failure.message,
          ));
        },
            (exam) {

          // Now handle the registered courses result
          registeredCoursesResult.fold(
                (failure) {
              emit(state.copyWith(
                isLoading: false,
                isFailure: true,
                errorMessage: failure.message,
              ));
            },
                (courses) {
              emit(state.copyWith(
                offlineExamModel: exam,
                registeredCourses: courses, // Add this field to your state
                isLoading: false,
                isDataLoaded: true
              ));
            },
          );
        },
      );
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: 'Unexpected error: $e',
      ));
    }
  }


  ///TODO:: REGISTERED COURSES REQUEST
  // void _handleUpdateOfflineExamEvent(
  //     UpdateOfflineExam event, Emitter<OfflineExamState> emit) async{
  //   emit(state.copyWith(
  //     isLoading: true
  //
  //   ));
  //   final result = await doctorExamRepoImp.getOfflineExam(UpdateOfflineExamRequest(examId:event.examId ));
  //   result.fold((failure) {
  //     emit(state.copyWith(
  //         errorMessage: failure.message,
  //      // offlineExamModel: state.offlineExamModel
  //       isFailure: true,
  //       isLoading: false
  //     ));
  //   }, (offlineExam) {
  //     emit(state.copyWith(
  //        offlineExamModel: offlineExam,
  //       isLoading: false,
  //       isDataLoaded: true
  //
  //     ));
  //   });
  // }

  void _handleUpdateDoctorOfflineExamEvent(
      UpdateDoctorOfflineExam event, Emitter<OfflineExamState> emit) async{
    dialogCubit.setStatus('Loading');
    final result = await doctorExamRepoImp.updateExam(UpdateExamRequest(examId:event.examId,
    exam: state.offlineExamModel
    ));
    result.fold((failure) {
      dialogCubit.setStatus('Failure', message: failure.message);
      emit(state.copyWith(
        errorMessage: failure.message,
       // offlineExamModel: state.offlineExamModel
        isFailure: true,
        isLoading: false
      ));
    }, (successMessage) {
      dialogCubit.setStatus('Success', message: successMessage);
      emit(state.copyWith(
        isLoading: false,
        isSuccess: true

      ));
    });
  }
  void _handleSetSuccessModeEvent(SetSuccessModeEvent event, Emitter<OfflineExamState> emit) {
    emit(state.copyWith(isSuccess: false));

  }
}
