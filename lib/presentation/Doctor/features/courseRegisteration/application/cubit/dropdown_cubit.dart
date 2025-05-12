
import 'package:bloc/bloc.dart';

import 'dropdown_state.dart';

class DropdownCubit extends Cubit<DropdownState> {

  DropdownCubit()
      : super(
    DropdownState(
      selectedCourses: {},
      isExpanded: {'Level 1 Courses': true},
    ),
  );

  void toggleDropdown(String id) {
    emit(
      state.copyWith(
        isExpanded: {
          ...state.isExpanded,
          id: !(state.isExpanded[id] ?? false),
        },
      ),
    );
  }
///////////////////////////////////////////////////////////////////////
  void selectCourse(String id, String courseIndex) {
    final currentSelected = state.selectedCourses[id] ?? [];
    final updatedSelected = currentSelected.contains(courseIndex)
        ? currentSelected.where((index) => index != courseIndex).toList()
        : [...currentSelected, courseIndex];

    emit(
      state.copyWith(
        selectedCourses: {
          ...state.selectedCourses,
          id: updatedSelected,
        },
      ),
    );
  }
/////////////////////////////////////////////////////////////////
  List<String> getSelectedCourses(String id) {
    return state.selectedCourses[id] ?? [];
  }

  void clearAllSelections() {
    emit(
      state.copyWith(selectedCourses: {}),
    );
  }

  Map<String, List<String>> getAllSelectedCourses() {
    return state.selectedCourses;

  }




}