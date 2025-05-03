part of 'exam_bloc.dart';
abstract class ExamEvent extends Equatable {
  const ExamEvent();

  @override
  List<Object> get props => [];
}

class FetchExamsEvent extends ExamEvent {

  final bool isExamtaken;

  FetchExamsEvent({required this.isExamtaken});
  @override
  List<Object> get props => [isExamtaken];
}




class DeleteExam extends ExamEvent {
  final int id;
  final bool isExamtaken;

  const DeleteExam(this.id, this.isExamtaken);

  @override
  List<Object> get props => [id, isExamtaken];
}


class GetStudentDegrees extends ExamEvent {
  final int examId;


  const GetStudentDegrees(this.examId);

  @override
  List<Object> get props => [examId];
}