
import 'dart:async';

import 'package:bloc/bloc.dart';


import '../domain/entities/course_details_entity.dart';


class StatusCubit extends Cubit<dynamic> {
  StatusCubit() : super(false);

  void setUploadingFile(CourseDetailsEntity file) {
    emit(file); // Emit file being uploaded
  }

  void clearStatus() {
    emit(false); // Clear upload status
  }
}


