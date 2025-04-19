part of 'courses_bloc.dart';

 class CoursesState extends Equatable {

  final bool tabStatus;

  CoursesState({ this.tabStatus = true});

 CoursesState changeTab(){
   return CoursesState(
     tabStatus:  !tabStatus
   );
 }
@override

  List<Object> get props => [tabStatus];
}

