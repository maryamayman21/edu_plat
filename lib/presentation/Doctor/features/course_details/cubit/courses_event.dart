part of 'courses_bloc.dart';

@immutable
sealed class CoursesEvent extends Equatable{
  CoursesEvent();
  @override
  List<Object?> get props => [];


}
class ChangeTab extends CoursesEvent{
  ChangeTab();
  @override
  List<Object?> get props => [];
}
