import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'courses_event.dart';
part 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  CoursesBloc() : super(CoursesState()) {
    on<ChangeTab>(_changeTabs);
  }


  Future<void> _changeTabs(ChangeTab event ,Emitter<CoursesState>emit )async{
    emit(state.changeTab());
  }
}
