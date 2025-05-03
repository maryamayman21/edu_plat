part of 'student_files_cubit.dart';

@immutable
sealed class StudentFilesState {}

final class StudentFilesInitial extends StudentFilesState {}
final class StudentFilesLoading extends StudentFilesState {}

final class StudentFilesSuccess extends StudentFilesState {
  final List<FileEntity> files;

  StudentFilesSuccess({required this.files});
}
final class StudentFilesFailure extends StudentFilesState {
  final String errorMessage;

  StudentFilesFailure({required this.errorMessage});
}
