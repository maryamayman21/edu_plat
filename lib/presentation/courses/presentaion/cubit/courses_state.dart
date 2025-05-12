part of 'courses_cubit.dart';

@immutable
sealed class CoursesState {}

final class CoursesInitial extends CoursesState {}
final class CoursesLoading extends CoursesState {}
final class CoursesSuccess extends CoursesState {
  final List<CourseEntity> courses;

  CoursesSuccess({required this.courses});
}
final class CoursesFailure extends CoursesState {
  final String errorMessage;

  CoursesFailure({required this.errorMessage});
}
