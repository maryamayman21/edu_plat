

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/course.dart';

abstract class DropdownStateBase {}
class DropdownInitialState extends DropdownStateBase {}
class DropdownLoadingState extends DropdownStateBase {}
class DropdownSuccessState extends DropdownStateBase {
  final List<Course> level1Courses;
  final List<Course> level2Courses;
  final List<Course> level3Courses;
  final List<Course> level4Courses;

  DropdownSuccessState({required this.level1Courses , required this.level2Courses , required this.level3Courses, required this.level4Courses});
}
class DropdownFailureState extends DropdownStateBase {
  final String errorMessage;

  DropdownFailureState({required this.errorMessage});
}
class DropdownState {
  //////////////////////////////////////////////////
  final Map<String, List<String>> selectedCourses;
  final Map<String, bool> isExpanded;

  DropdownState({required this.selectedCourses, required this.isExpanded});

  DropdownState copyWith({
    ///////////////////////////////////////////////////////////////
    Map<String, List<String>>? selectedCourses,
    Map<String, bool>? isExpanded,
  }) {
    return DropdownState(
      selectedCourses: selectedCourses ?? this.selectedCourses,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }
}

class DropdownData  {
  final bool isExpanded;
  ////////////////////////////////////////////
  final List<String> selectedCourses;

  const DropdownData({required this.isExpanded, required this.selectedCourses});

  DropdownData copyWith({
    bool? isExpanded,
    ////////////////////////////////////////////////
    List<String>? selectedCourses,
  }) {
    return DropdownData(
      isExpanded: isExpanded ?? this.isExpanded,
      selectedCourses: selectedCourses ?? this.selectedCourses,
    );
  }
}