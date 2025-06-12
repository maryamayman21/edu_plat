part of 'pdf_exam_bloc.dart';


abstract class PDFExamEvent extends Equatable {
  const PDFExamEvent();

  @override
  List<Object> get props => [];
}

//class AddQuestionEvent extends PDFExamEvent {}
class AddQuestionWithOptionsEvent extends PDFExamEvent {
  final String questionText;
  final int? questionDegree;
  final List<String> options;
  const AddQuestionWithOptionsEvent(this.questionDegree,  { required this.questionText, required this.options,});
}
class RemoveQuestionEvent extends PDFExamEvent {
  final int index;
  const RemoveQuestionEvent(this.index);
}

class UpdateQuestionEvent extends PDFExamEvent {
  final int index;
  final String question;
  const UpdateQuestionEvent(this.index, this.question);
}

class AddOptionEvent extends PDFExamEvent {
  final int questionIndex;
  const AddOptionEvent(this.questionIndex);
}

class RemoveOptionEvent extends PDFExamEvent {
  final int questionIndex;
  final int optionIndex;
  const RemoveOptionEvent(this.questionIndex, this.optionIndex);
}

class UpdateOptionEvent extends PDFExamEvent {
  final int questionIndex;
  final int optionIndex;
  final String option;
  const UpdateOptionEvent(this.questionIndex, this.optionIndex, this.option);
}



class SetExamDateEvent extends PDFExamEvent {
  final DateTime? examDate;
  const SetExamDateEvent ( {required this.examDate,});
}

class UpdateQuestionMarkEvent extends PDFExamEvent {
  final int? mark;
  final int questionIndex;
  const UpdateQuestionMarkEvent(this.mark , this.questionIndex);
}

class CreateExamEvent extends PDFExamEvent {
  const CreateExamEvent();
}

class SetUpExamEvent extends PDFExamEvent {
   const SetUpExamEvent();
}
class FetchCourseDataEvent extends PDFExamEvent {
  final String courseCode;
  const FetchCourseDataEvent({required this.courseCode});
}
class SetSuccessModeEvent extends PDFExamEvent {
  const SetSuccessModeEvent();
}