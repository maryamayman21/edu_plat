import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/question_model.dart';

class ExamModel {
  final String courseCode;
  final int totalDegrees;  //when adding new question -> updates
  final int noOfQuestions; //when adding new question -> updates
  final DateTime examDate;
  final Duration examDuration; // //when adding new question -> updates
  final List<QuestionModel> question;
   bool isValid = false;

  ExamModel({
    required this.courseCode,
    this.totalDegrees = 0 ,
    this.noOfQuestions  = 0 ,
    required this.examDate,
     required this.examDuration  ,
    required this.question,
    this.isValid = false
  });

  factory ExamModel.initial() {
    return ExamModel(
        courseCode: '',
        examDate: DateTime.now(),
        examDuration: const Duration(minutes: 0),
        question: [],
       isValid: false
    );
  }

  ExamModel copyWith({
    String? courseCode,
    int? totalDegrees,
    int? noOfQuestions,
    DateTime? examDate,
    Duration? examDuration,
    List<QuestionModel>? question,
    bool? isValid
  }) {
    return ExamModel(
      courseCode: courseCode ?? this.courseCode,
      totalDegrees: totalDegrees ?? this.totalDegrees,
      noOfQuestions: noOfQuestions ?? this.noOfQuestions,
      examDate: examDate ?? this.examDate,
      examDuration: examDuration ?? this.examDuration,
      question: question ?? this.question,
      isValid: isValid ?? this.isValid
    );
  }
}


// class OfflineExamModel extends ExamModel{
//   final String location;
//
//   OfflineExamModel({ required String courseCode, required int totalDegrees , required int noOfQuestions , required DateTime examDate , required DateTime examDuration ,  required List<QuestionModel> question, required,required this.location}) : super(courseCode: courseCode, examDate: examDate, examDuration: examDuration, noOfQuestions: noOfQuestions, totalDegrees: totalDegrees, question: question);
//
//
//
// }