part of 'exam_bloc.dart';

abstract class ExamState extends Equatable {
  const ExamState();

  @override
  List<Object> get props => [];
}

class ExamInitial extends ExamState {}
class ExamLoading extends ExamState {}
class ExamsIsEmpty extends ExamState {}
class ExamsNoWifi extends ExamState {}

class ExamLoaded extends ExamState {
  final List<ExamEntity> exams;

  const ExamLoaded(this.exams);

  @override
  List<Object> get props => [exams];
}

class ExamError extends ExamState {
  final String message;

  const ExamError(this.message);

  @override
  List<Object> get props => [message];
}
class StudentDegreesLoaded extends ExamState {
  final List<StudentDegreeEntity> studentDegrees;

   StudentDegreesLoaded({required this.studentDegrees});

  @override
  List<Object> get props => [studentDegrees];
}
