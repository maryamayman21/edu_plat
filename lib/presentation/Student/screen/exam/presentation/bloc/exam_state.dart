part of 'exam_bloc.dart';

abstract class ExamState extends Equatable {
  const ExamState();

  @override
  List<Object> get props => [];
}

class ExamInitial extends ExamState {}
class ExamLoading extends ExamState {}

class ExamCardsLoaded extends ExamState {
  final List<StudentExamCardEntity> exams;

  const ExamCardsLoaded(this.exams);

  @override
  List<Object> get props => [exams];
}class ExamQuestionsLoaded extends ExamState {
  final List<QuestionModel> questions;

  const ExamQuestionsLoaded(this.questions);

  @override
  List<Object> get props => [questions];
}

class ExamSuccess extends ExamState{
  final String successMessage;
  const ExamSuccess(this.successMessage);
}

class ExamError extends ExamState {
  final String message;

  const ExamError(this.message);

  @override
  List<Object> get props => [message];
}
class ExamLoaded extends ExamState {
  final StudentExamModel exam;
  const ExamLoaded(this.exam);
}

class ExamStarted extends ExamState {
  final int examId;
  final List<StudentExamCardEntity> examCards; // Add examCards to the state
  ExamStarted(this.examCards, this.examId);
}