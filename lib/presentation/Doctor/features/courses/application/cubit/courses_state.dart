part of 'courses_cubit.dart';

@immutable
sealed class CoursesState {}

final class CoursesInitial extends CoursesState {}
final class CoursesLoading extends CoursesState {

  final  courses;

  CoursesLoading({this.courses});
}
final class GetCoursesLoading extends CoursesState {
  GetCoursesLoading();
}
final class CourseDeletionSuccess extends CoursesState {
  final successMessage;
  final  courses;
  CourseDeletionSuccess(this.successMessage , this.courses);
}
final class CoursesSuccess extends CoursesState {
  final  courses;
  CoursesSuccess(this.courses);
}
final class CoursesFailure extends CoursesState {
  final String errorMessage;
  CoursesFailure(this.errorMessage);
}
final class CoursesNotFound extends CoursesState {
  CoursesNotFound();
}
final class CoursesDeletionFailure extends CoursesState {
  final  courses;
  CoursesDeletionFailure(this.courses);
}
final class CoursesDeletion extends CoursesState {
  final List<String> updatedCourses;
  CoursesDeletion(this.updatedCourses);
}