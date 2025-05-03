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




class FetchExamQuestions extends ExamEvent {
  final int examId;
  final int doctorId;
  final String courseCode;

  const FetchExamQuestions(this.examId, this.doctorId, this.courseCode);

  @override
  List<Object> get props => [examId, doctorId, courseCode];
}
 class StartExamEvent extends ExamEvent {
  final int examId;
  const StartExamEvent(this.examId);

  @override
  List<Object> get props => [examId];
}
class SubmitExamScore extends ExamEvent {
 final SubmitExamModel exam;

  const SubmitExamScore(this.exam );

  @override
  List<Object> get props => [exam];
}

class CheckExamStartTime extends ExamEvent {}
class UpdateExamStartTime extends ExamEvent {
  final DateTime examStartTime;
  final int  examId;
  UpdateExamStartTime(this.examStartTime, this.examId);
}