import 'package:bloc/bloc.dart';
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
      dialogCubit.setStatus('Failure');
      // emit(state.copyWith(
      //   offlineExamModel: state.offlineExamModel
      // ));
    }, (successMessage) {
      emit(state.copyWith(
          isSuccess: true
      ));
    });
  }
  void _handleUpdateOfflineExamEvent(
      UpdateOfflineExam event, Emitter<OfflineExamState> emit) async{
    //dialogCubit.setStatus('Loading');


    emit(state.copyWith(
      isLoading: true

    ));
    final result = await doctorExamRepoImp.getOfflineExam(UpdateOfflineExamRequest(examId:event.examId ));


    print('Got offline exam');
    result.fold((failure) {
      print('Failed to  offline exam');
      emit(state.copyWith(
          errorMessage: failure.message,
       // offlineExamModel: state.offlineExamModel
        isFailure: true,
        isLoading: false
      ));
    }, (offlineExam) {
      print('Got offline exam');
      emit(state.copyWith(
         offlineExamModel: offlineExam,
        isLoading: false,
        isDataLoaded: true

      ));
    });
  }void _handleUpdateDoctorOfflineExamEvent(
      UpdateDoctorOfflineExam event, Emitter<OfflineExamState> emit) async{
    //dialogCubit.setStatus('Loading');

    dialogCubit.setStatus('Loading');
    // emit(state.copyWith(
    //   isLoading: true
    //
    // ));
    final result = await doctorExamRepoImp.updateExam(UpdateExamRequest(examId:event.examId,
    exam: state.offlineExamModel
    ));


    print('Got offline exam');
    result.fold((failure) {
      print('Failed to  offline exam');
      dialogCubit.setStatus('Failure');
      emit(state.copyWith(
        errorMessage: failure.message,
       // offlineExamModel: state.offlineExamModel
        isFailure: true,
        isLoading: false
      ));
    }, (successMessage) {
      dialogCubit.setStatus('Success');
     // print('Got offline exam');
      emit(state.copyWith(
        isLoading: false,
        isSuccess: true

      ));
    });
  }
}
