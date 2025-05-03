import 'package:edu_platt/presentation/Student/screen/exam/data/model/student_question_model.dart';

class StudentExamModel {
  final int id;
  final String examTitle;
  final String startTime;
  final int totalMarks;
  final bool isOnline;
  final int qusetionsNumber;
  final int durationInMin;
  final String courseCode;
  final String location;
  final int doctorId;
  final List<StudentQuestionModel> questions;

  // Default Constructor
  StudentExamModel({
    required this.id,
    required this.examTitle,
    required this.startTime,
    required this.totalMarks,
    required this.isOnline,
    required this.qusetionsNumber,
    required this.durationInMin,
    required this.courseCode,
    required this.location,
    required this.doctorId,
    required this.questions,
  });

  // Named Constructor with Default Values (Initialization Constructor)
  StudentExamModel.init({
    this.id = 0,
    this.examTitle = '',
    this.startTime = '',
    this.totalMarks = 0,
    this.isOnline = false,
    this.qusetionsNumber = 0,
    this.durationInMin = 0,
    this.courseCode = '',
    this.location = '',
    this.doctorId = 0,
    this.questions = const [],
  });

  // Named Constructor for creating from JSON
  factory StudentExamModel.fromJson(Map<String, dynamic> json) {
    return StudentExamModel(
      id: json['id'],
      examTitle: json['examTitle'],
      startTime:DateTime.parse(json['startTime']).toLocal().toString(),
      totalMarks: json['totalMarks'],
      isOnline: json['isOnline'],
      qusetionsNumber: json['qusetionsNumber'],
      durationInMin: json['durationInMin'],
      courseCode: json['courseCode'],
      location: json['location'],
      doctorId: json['doctorId'],
      questions: (json['questions'] as List)
          .map((q) => StudentQuestionModel.fromJson(q))
          .toList(),
    );
  }

  // Method for converting the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'examTitle': examTitle,
      'startTime': startTime,
      'totalMarks': totalMarks,
      'isOnline': isOnline,
      'qusetionsNumber': qusetionsNumber,
      'durationInMin': durationInMin,
      'courseCode': courseCode,
      'location': location,
      'doctorId': doctorId,
      'questions': questions.map((q) => q.toJson()).toList(),
    };
  }
}
