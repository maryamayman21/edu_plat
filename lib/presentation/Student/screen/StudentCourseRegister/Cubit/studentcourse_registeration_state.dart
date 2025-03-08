part of 'Student_Course_RegisterCubit.dart';

@immutable
sealed class StudentCourseRegisterationState {}

final class CourseRegisterationInitial extends StudentCourseRegisterationState {}
final class CoursesRegistered extends StudentCourseRegisterationState {
  final message;
  CoursesRegistered(this.message);
}
final class CourseRegisterationLoading extends StudentCourseRegisterationState {}
final class CourseRegisterationSuccess extends StudentCourseRegisterationState {
 final List<Course> level1Courses;
 final List<Course> leve21Courses;
 final List<Course> leve31Courses;
 final List<Course> leve41Courses;


  CourseRegisterationSuccess(this.level1Courses, this.leve21Courses, this.leve31Courses, this.leve41Courses);
}
final class CourseRegisterationFailure extends StudentCourseRegisterationState {
 final String errorMessage;
 CourseRegisterationFailure(this.errorMessage);
}
