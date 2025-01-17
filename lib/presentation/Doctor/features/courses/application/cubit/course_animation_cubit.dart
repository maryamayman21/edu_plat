import 'package:bloc/bloc.dart';

import '../../../../../../core/DataModel/courseModel.dart';

class AnimationCubit extends Cubit<List<int>> {
  AnimationCubit() : super([]);

  void insertItems(int itemCount) async {
    for (int i = 0; i < itemCount; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      emit(List.from(state)..add(i));
    }
  }
}










// class AnimationCubit extends Cubit<List<int>> {
//   AnimationCubit() : super([]);
//
//   void initialize(List<CourseModel> courses) {
//     for (int i = 0; i < courses.length; i++) {
//       Future.delayed(Duration(milliseconds: i * 200), () {
//         emit([...state, i]);
//       });
//     }
//   }
// }

