import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/model.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details_utils/file_picker_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';



part 'linear_progress_state.dart';

class LinearProgressCubit extends Cubit<LinearProgressState> {
  LinearProgressCubit({
    required this .filePickerService
  }) : super(LinearProgressInitial(0.0));
  final FilePickerService filePickerService;

  void startLoadingAnimation(AnimationController controller) {
    controller.forward();
  }

  void isAnimationComplete(AnimationController controller) {
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        emit(LinearProgressCompleted());
      }
    });
  }

  void selectFile() async {
    final file = await filePickerService.pickFile();

    FileData fileData = FileData(
        date: DateTime.now() ,
        extension: file!.files.single.extension!,
        name:  file!.files.single.name,
        path: file!.files.single.path!,
        size: file!.files.single.size
      );


    ///TODO::: SERVER CALL

    ///TODO:: EMIT NEW STATE


  }
}


