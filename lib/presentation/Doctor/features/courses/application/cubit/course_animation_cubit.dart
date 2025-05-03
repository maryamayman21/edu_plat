import 'package:bloc/bloc.dart';


class AnimationCubit extends Cubit<List<int>> {
  AnimationCubit() : super([]);

  void insertItems(int itemCount) async {
    for (int i = 0; i < itemCount; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      emit(List.from(state)..add(i));
    }
  }
}

