part of 'course_files_cubit.dart';

@immutable
sealed class CourseFilesState {}

final class CourseDetailsInitial extends CourseFilesState {}
class CourseFilesLoading extends CourseFilesState{}
class CourseFilesSuccess extends CourseFilesState{
  final List<CourseFileEntity> coursesFiles;
  CourseFilesSuccess({required this.coursesFiles});
}
class CourseFilesNotFound extends CourseFilesState{}
class CourseFilesFailure extends CourseFilesState{
  final String errorMessage ;
  CourseFilesFailure({required this.errorMessage});
}


