part of 'Studentcourses_cubit.dart';

@immutable
sealed class StudentCoursesState {}

final class CoursesInitial extends StudentCoursesState {}
final class CoursesLoading extends StudentCoursesState {

  final  courses;

  CoursesLoading({this.courses});
}
final class GetCoursesLoading extends StudentCoursesState {
  GetCoursesLoading();
}
final class CourseDeletionSuccess extends StudentCoursesState {
  final successMessage;
  final  courses;
  CourseDeletionSuccess(this.successMessage , this.courses);
}
final class CoursesSuccess extends StudentCoursesState {
  final  courses;
  CoursesSuccess(this.courses);
}
final class CoursesFailure extends StudentCoursesState {
  final String errorMessage;
  CoursesFailure(this.errorMessage);
}
final class CoursesNotFound extends StudentCoursesState {
  CoursesNotFound();
}
final class CoursesDeletionFailure extends StudentCoursesState {
  final  courses;
  CoursesDeletionFailure(this.courses);
}
final class CoursesDeletion extends StudentCoursesState {
  final List<String> updatedCourses;
  CoursesDeletion(this.updatedCourses);
}