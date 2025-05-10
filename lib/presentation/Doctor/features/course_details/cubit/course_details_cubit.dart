import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/cubit/tab_index_cubit.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/cubit/uploading_status.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/domain/entities/course_details_entity.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/domain/repos/course_details_repo.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/network/requests/course_details_requests/fetch_file_request.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/network/requests/course_details_requests/update_file_request.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/network/requests/course_details_requests/upload_file_request.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details_utils/file_picker_service.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/presentation/cubit/material_type_cubit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dialog_cubit.dart';
part 'course_details_state.dart';


class CourseDetailsCubit extends Cubit<CourseDetailsState> {
  int tabIndex = 0 ;
 // bool action = false;
 final String courseCode;
  CourseDetailsCubit(
   {required this.dialogCubit,
     required this.statusCubit,
     required this.materialTypeCubit,
    required this.courseDetailsRepo,
     required this.filePickerService,
     required this.courseCode
    }) : super(CourseFilesLoading()){

    materialTypeSubscription = materialTypeCubit.stream.listen((materialType) {
      materialMap= materialType ;
      fetchCourseFiles(materialMap['materialType'], courseCode,);
    });
    fetchCourseFiles(materialMap['materialType'], courseCode,);

  }

  Map<String, dynamic> materialMap = {'materialType':'Lectures', 'currentIndex': 0} ;
  final MaterialTypeCubit materialTypeCubit;
  late StreamSubscription<Map<String, dynamic>> materialTypeSubscription;
  CourseDetailsRepo courseDetailsRepo;
  final FilePickerService filePickerService;
  final DialogCubit dialogCubit;
  final StatusCubit statusCubit;




  Future<void> fetchCourseFiles(String type, String courseCode) async {
     emit(CourseFilesLoading());
    var result = await courseDetailsRepo.fetchCourseFiles(FetchFileRequest(type: type, courseCode: courseCode));
    result.fold((failure) {
      emit(CourseFilesFailure(errorMessage: failure.message));
    }, (coursesFiles) {
       if(coursesFiles.isEmpty){
         emit(CourseFilesNotFound());
       }
       else{
         emit(CourseFilesSuccess(coursesFiles: coursesFiles));
       }

    });
  }
Future<void> fetchCourseFilesRequest() async {
  fetchCourseFiles(materialMap['materialType'], courseCode,);
  }

  CancelToken? cancelToken;
  void cancelUpload() async {
    cancelToken?.cancel("Canceled");
  }

  Future<void> saveCourseFile() async {
    final courseFile = await getCourseFileEntity();
    statusCubit.setUploadingFile(courseFile);
    var result = await courseDetailsRepo.saveCoursesFiles(UploadFileRequest(file:File(courseFile.path!) , type: courseFile.type, courseCode: courseCode),);
    result.fold((failure) {
      if(materialMap['materialType'] == courseFile.type){
        emit(CourseFilesFailure(errorMessage: failure.message));
      }

      statusCubit.clearStatus();
    }, (coursesFiles) {
       if(materialMap['materialType'] == courseFile.type){
         emit(CourseFilesSuccess(coursesFiles: coursesFiles));
       }
      statusCubit.clearStatus();
    });
  }

  ///helper method
  Future<CourseDetailsEntity> getCourseFileEntity()async{
    final file = await pickMedia();
   // if(file == null){}
    CourseDetailsEntity courseFile = CourseDetailsEntity(
       courseCode: courseCode,
        date: '',
        name:  file!.files.single.name,
        path: file!.files.single.path!,
        size:file!.files.single.size.toString(),
        extention: file!.files.single.extension!,
       type: materialMap['materialType'],
        // type: tabs[indexCubit.state],
        id: null
    );
    return courseFile;
  }



  Future<FilePickerResult?> pickMedia()async{
    switch(materialMap['currentIndex']){
      case 0 :
      case 1 :
      case 2 :
      return await filePickerService.pickFile();
      case 3 :
       return await filePickerService.pickVideo();
    }

  }

  Future<void> deleteFile(int fileIndex) async {

    if (dialogCubit.isClosed) return;
      dialogCubit.setStatus('Loading');
      var result = await courseDetailsRepo.deleteCoursesFile(
          fileIndex, materialMap['materialType'], courseCode);
      result.fold((failure) {
        dialogCubit.setStatus('Failure', message:  failure.message);
        emit(CourseFilesFailure(errorMessage: failure.message));
      }, (coursesFiles) {
        if (coursesFiles.isEmpty) {
          dialogCubit.setStatus('Success');
          emit(CourseFilesNotFound());
        }
        else {
          dialogCubit.setStatus('Success');
          emit(CourseFilesSuccess(coursesFiles: coursesFiles));
        }
      });
    }

  Future<void> updateFile(int fileIndex  ) async {
    if (dialogCubit.isClosed) return;
    final courseFile = await getCourseFileEntity();
    dialogCubit.setStatus('Loading');
    var result = await courseDetailsRepo.updateCoursesFile(fileIndex , courseFile.type! ,  File(courseFile.path!), courseFile.courseCode);
    result.fold((failure) {
      dialogCubit.setStatus('Failure', message: failure.message);
      emit(CourseFilesFailure(errorMessage: failure.message));
    }, (coursesFiles) {
      if (coursesFiles.isEmpty) {
        dialogCubit.setStatus('Success');
        emit(CourseFilesNotFound());
      }
      else {
        dialogCubit.setStatus('Success');
        emit(CourseFilesSuccess(coursesFiles: coursesFiles));
      }
    });
  }

  Future<void> downloadFile( String filePath , String fileName ,   int fileIndex ) async {

    emit(CourseFilesLoading());
    await Future.delayed(const Duration(seconds: 10));
    var result = await courseDetailsRepo.downloadFile(filePath, fileName , fileIndex);
    result.fold((failure) {
      emit(CourseFilesFailure(errorMessage: failure.message));
    }, (file) {
         emit(OnFileSuccess(file: file));
      }

    );
  }




  @override
  Future<void> close() {
    return super.close();
  }
}

