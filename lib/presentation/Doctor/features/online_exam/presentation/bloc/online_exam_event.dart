part of 'online_exam_bloc.dart';






abstract class OnlineExamEvent extends Equatable {
  const OnlineExamEvent();

  @override
  List<Object> get props => [];
}

//class AddQuestionEvent extends OnlineExamEvent {}

class RemoveQuestionEvent extends OnlineExamEvent {
  final int index;
  const RemoveQuestionEvent(this.index);
}

class UpdateQuestionEvent extends OnlineExamEvent {
  final int index;
  final String question;
  const UpdateQuestionEvent(this.index, this.question);
}

class AddOptionEvent extends OnlineExamEvent {
  final int questionIndex;
  const AddOptionEvent(this.questionIndex);
}

class RemoveOptionEvent extends OnlineExamEvent {
  final int questionIndex;
  final int optionIndex;
  const RemoveOptionEvent(this.questionIndex, this.optionIndex);
}

class UpdateOptionEvent extends OnlineExamEvent {
  final int questionIndex;
  final int optionIndex;
  final String option;
  const UpdateOptionEvent(this.questionIndex, this.optionIndex, this.option);
}

class SelectCorrectAnswerEvent extends OnlineExamEvent {
  final int questionIndex;
  final int optionIndex;
  const SelectCorrectAnswerEvent(this.questionIndex, this.optionIndex);
}

class AddQuestionWithOptionsEvent extends OnlineExamEvent {
  final String questionText;
  final List<String> options;
  final Duration duration;
  final int questionDegree;
 final int correctAnswerIndex;
  const AddQuestionWithOptionsEvent( {required this.correctAnswerIndex,  required this.questionText, required this.options, required this.duration, required this.questionDegree});
}

class UpdateQuestionDurationEvent extends OnlineExamEvent {
  final Duration? questionDuration;
  final int questionIndex;
  const UpdateQuestionDurationEvent(this.questionDuration, this.questionIndex);
}
class SetExamDateEvent extends OnlineExamEvent {
  final DateTime? examDate;
  const SetExamDateEvent (this.examDate);
}

class UpdateQuestionMarkEvent extends OnlineExamEvent {
  final int? mark;
  final int questionIndex;
  const UpdateQuestionMarkEvent(this.mark , this.questionIndex);
}

class UpdateExamDetailsEvent extends OnlineExamEvent {
  final String? courseCode;
  final int? totalDegrees;
  final int? noOfQuestions;
  final DateTime? examDate;

  const UpdateExamDetailsEvent({this.courseCode, this.totalDegrees, this.noOfQuestions, this.examDate});
}

class SetExamCourseCodeEvent extends OnlineExamEvent {
  final String courseCode;
  const SetExamCourseCodeEvent(this.courseCode);
}
class SetExamCourseTitleEvent extends OnlineExamEvent {
  final String courseTitle;
  const SetExamCourseTitleEvent(this.courseTitle);
}

class CreateExamEvent extends OnlineExamEvent {
  const CreateExamEvent();
}

//update exam
class UpdateExamEvent extends OnlineExamEvent {
  final int examId; // Add this field

  const UpdateExamEvent({required this.examId});

  @override
  List<Object> get props => [examId];
}
class UpdateDoctorExamEvent extends OnlineExamEvent {
  final int examId; // Add this field

  const UpdateDoctorExamEvent({required this.examId});

  @override
  List<Object> get props => [examId];
}

class ClearErrorMessageEvent extends OnlineExamEvent {
  const ClearErrorMessageEvent();
}


// //update exam
// class CreateExamEvent extends OnlineExamEvent {
//   final int examId; // Add this field
//
//   const UpdateExamEvent({required this.examId});
//
//   @override
//   List<Object> get props => [examId];
// }
