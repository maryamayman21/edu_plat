part of 'course_details_cubit.dart';



abstract class CourseDetailsState {
}

class CourseFilesInitial extends CourseDetailsState{}
class CourseFilesLoading extends CourseDetailsState{}
class CourseFilesSuccess extends CourseDetailsState{
 final List<CourseDetailsEntity> coursesFiles;
 CourseFilesSuccess({required this.coursesFiles});
}
class CourseFilesNotFound extends CourseDetailsState{}
class  OnFileSuccess extends CourseDetailsState{
  final File file;
  OnFileSuccess({required this.file});
}
class CourseFilesFailure extends CourseDetailsState{
  final String errorMessage ;
  CourseFilesFailure({required this.errorMessage});
}
