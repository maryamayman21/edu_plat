import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/cubit/tab_index_cubit.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/data/network/request/course_card_request.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/data/network/request/fetch_file_request.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/domain/entity/course_card_entity.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/domain/entity/course_file_entity.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/domain/repo/course_details_repo.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/presentation/cubit/material_type_cubit.dart';
import 'package:meta/meta.dart';

part 'course_files_state.dart';

class CourseFilesCubit extends Cubit<CourseFilesState> {
  CourseFilesCubit(  {  required this.doctorId, required this.courseDetailsRepo,required this.courseCode, required this.materialTypeCubit,}) : super(CourseDetailsInitial()){


    materialTypeSubscription = materialTypeCubit.stream.listen((materialType) {
      materialMap= materialType ;
      fetchCourseFiles(materialMap['materialType'], courseCode, doctorId);

      print(materialMap['materialType']);
    });
    fetchCourseFiles(materialMap['materialType'], courseCode, doctorId);
  }
  final CourseDetailsRepo courseDetailsRepo;
  Map<String, dynamic> materialMap = {'materialType':'Lectures', 'currentIndex': 0} ;
  final String doctorId;
  final String courseCode;
   final MaterialTypeCubit materialTypeCubit;
  late StreamSubscription<Map<String, dynamic>> materialTypeSubscription;



  Future<void> fetchCourseFiles(String type, String courseCode, String doctorId) async {
    emit(CourseFilesLoading());
    var result = await courseDetailsRepo.fetchCourseFiles(FetchFileRequest(type: type, courseCode: courseCode, doctorId:doctorId ));
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

}
