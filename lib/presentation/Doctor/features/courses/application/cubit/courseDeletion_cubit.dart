import 'package:bloc/bloc.dart';
import 'package:edu_platt/core/DataModel/courseModel.dart';


import '../../../../../../core/cashe/services/course_cashe_service.dart';

class DeletionCubit extends Cubit<List<CourseModel>> {

  DeletionCubit(List<CourseModel> courses) : super(courses);

  void deleteCourse(int index) {
    final newState = [...state];
    newState.removeAt(index);
    emit(newState);
  }







}