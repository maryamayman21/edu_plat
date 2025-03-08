part of 'course_card_cubit.dart';

@immutable
sealed class CourseCardState {}

final class CourseCardInitial extends CourseCardState {}
class CourseCardLoading extends CourseCardState{}
class CourseCardSuccess extends CourseCardState{
  final CourseCardEntity courseCardEntity;
  CourseCardSuccess({required this.courseCardEntity});
}
class CourseCardFailure extends CourseCardState{
  final String errorMessage ;
  CourseCardFailure({required this.errorMessage});
}
