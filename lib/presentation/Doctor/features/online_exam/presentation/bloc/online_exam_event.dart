part of 'online_exam_bloc.dart';
@immutable
sealed class OnlineExamEvent {}

//class AddQuestionEvent extends OnlineExamEvent {}

class RemoveQuestionEvent extends OnlineExamEvent {
  final int index;
  RemoveQuestionEvent(this.index);
}

class UpdateQuestionEvent extends OnlineExamEvent {
  final int index;
  final String question;
  UpdateQuestionEvent(this.index, this.question);
}

class AddOptionEvent extends OnlineExamEvent {
  final int questionIndex;
  AddOptionEvent(this.questionIndex);
}

class RemoveOptionEvent extends OnlineExamEvent {
  final int questionIndex;
  final int optionIndex;
  RemoveOptionEvent(this.questionIndex, this.optionIndex);
}

class UpdateOptionEvent extends OnlineExamEvent {
  final int questionIndex;
  final int optionIndex;
  final String option;
  UpdateOptionEvent(this.questionIndex, this.optionIndex, this.option);
}

class SelectCorrectAnswerEvent extends OnlineExamEvent {
  final int questionIndex;
  final int optionIndex;
  SelectCorrectAnswerEvent(this.questionIndex, this.optionIndex);
}

class AddQuestionWithOptionsEvent extends OnlineExamEvent {
  final String questionText;
  final List<String> options;
  final Duration duration;
  final int questionDegree;
 final int correctAnswerIndex;
  AddQuestionWithOptionsEvent( {required this.correctAnswerIndex,  required this.questionText, required this.options, required this.duration, required this.questionDegree});
}

class UpdateQuestionDurationEvent extends OnlineExamEvent {
  final Duration questionDuration;
  final int questionIndex;
  UpdateQuestionDurationEvent(this.questionDuration, this.questionIndex);
}
class SetExamDateEvent extends OnlineExamEvent {
  final DateTime examDate;
  SetExamDateEvent (this.examDate);
}

class UpdateQuestionMarkEvent extends OnlineExamEvent {
  final int? mark;
  final int questionIndex;
  UpdateQuestionMarkEvent(this.mark , this.questionIndex);
}

class UpdateExamDetailsEvent extends OnlineExamEvent {
  final String? courseCode;
  final int? totalDegrees;
  final int? noOfQuestions;
  final DateTime? examDate;

  UpdateExamDetailsEvent({this.courseCode, this.totalDegrees, this.noOfQuestions, this.examDate});
}

class SetExamCourseCodeEvent extends OnlineExamEvent {
  final String courseCode;
  SetExamCourseCodeEvent(this.courseCode);
}

class CreateExamEvent extends OnlineExamEvent {
  //validation
  //true -> data source
  //false list -> question index + error message

  CreateExamEvent();
}
