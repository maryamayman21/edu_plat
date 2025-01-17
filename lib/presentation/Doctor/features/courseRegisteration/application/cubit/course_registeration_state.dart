part of 'course_registeration_cubit.dart';

@immutable
sealed class CourseRegisterationState {}

final class CourseRegisterationInitial extends CourseRegisterationState {}
final class CoursesRegistered extends CourseRegisterationState {
  final message;
  CoursesRegistered(this.message);
}
final class CourseRegisterationLoading extends CourseRegisterationState {}
final class CourseRegisterationSuccess extends CourseRegisterationState {
 final List<Course> level1Courses;
 final List<Course> leve21Courses;
 final List<Course> leve31Courses;
 final List<Course> leve41Courses;


  CourseRegisterationSuccess(this.level1Courses, this.leve21Courses, this.leve31Courses, this.leve41Courses);
}
final class CourseRegisterationFailure extends CourseRegisterationState {
 final String errorMessage;
 CourseRegisterationFailure(this.errorMessage);
}
