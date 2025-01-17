import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0); // Default tab is the first one.

  void changeTab(int index) {
    emit(index); // Emit the new index when a tab is selected.
  }
}
