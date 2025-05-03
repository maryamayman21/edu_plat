import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/question_model.dart';

// Base class for common exam properties and methods
class BaseExamModel {
  final String examTitle;
  final String courseCode;
  final DateTime examDate;
  final Duration examDuration;
  final int totalMark;
  final bool isOnline;

  BaseExamModel({
    required this.examTitle,
    required this.courseCode,
    required this.examDate,
    required this.examDuration,
    required this.totalMark,
    this.isOnline = true,
  });

  // Common copyWith method for base properties
  BaseExamModel copyWith({
    String? examTitle,
    String? courseCode,
    DateTime? examDate,
    Duration? examDuration,
    bool? isOnline,
    int? totalMark
  }) {
    return BaseExamModel(
      examTitle: examTitle ?? this.examTitle,
      courseCode: courseCode ?? this.courseCode,
      examDate: examDate ?? this.examDate,
      examDuration: examDuration ?? this.examDuration,
      isOnline: isOnline ?? this.isOnline,
      totalMark: totalMark?? this.totalMark
    );
  }

  // Common toJson method for base properties
  Map<String, dynamic> toJson() {
    return {
      'examTitle': examTitle,
      'courseCode': courseCode,
      'startTime': examDate.toUtc().toIso8601String(),
      'durationInMin': examDuration.inMinutes,
      'isOnline': isOnline,
      'totalMarks':totalMark
    };
  }

  // Common initial method for base properties
  factory BaseExamModel.initial() {
    return BaseExamModel(
      examTitle: '',
      courseCode: '',
      examDate: DateTime.now(),
      examDuration: const Duration(minutes: 0),
      isOnline: true,
      totalMark: 0
    );
  }
}

// OnlineExamModel extends BaseExamModel
class OnlineExamModel extends BaseExamModel {

  final int noOfQuestions;
  final List<QuestionModel> question;
  final bool isValid;

  OnlineExamModel({
    required String examTitle,
    required String courseCode,
    required DateTime examDate,
    required Duration examDuration,
     required int totalMark,
    this.noOfQuestions = 0,
    required this.question,
    this.isValid = false,
    bool isOnline = true,
  }) : super(
    examTitle: examTitle,
    courseCode: courseCode,
    examDate: examDate,
    examDuration: examDuration,
    totalMark: totalMark,
    isOnline: isOnline,
  );

  // CopyWith method for OnlineExamModel
  @override
  OnlineExamModel copyWith({
    String? examTitle,
    String? courseCode,
    DateTime? examDate,
    Duration? examDuration,
    int? noOfQuestions,
    List<QuestionModel>? question,
    bool? isValid,
    bool? isOnline,
    int? totalMark
  }) {
    return OnlineExamModel(
      examTitle: examTitle ?? this.examTitle,
      courseCode: courseCode ?? this.courseCode,
      examDate: examDate ?? this.examDate,
      examDuration: examDuration ?? this.examDuration,
      noOfQuestions: noOfQuestions ?? this.noOfQuestions,
      question: question ?? this.question,
      isValid: isValid ?? this.isValid,
      totalMark: totalMark?? this.totalMark,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  // FromJson method for OnlineExamModel
  factory OnlineExamModel.fromJson(Map<String, dynamic> json) {
    return OnlineExamModel(
      totalMark: json['totalMarks'] ?? 0,
      examTitle: json['examTitle'] ?? '',
      courseCode: json['courseCode'] ?? '',
      examDate: DateTime.parse(json['startTime']),///TODO:: Test
      examDuration: Duration(minutes: json['durationInMin'] ?? 0),
      noOfQuestions: json['questionsNumber'] ?? 0,
      question: (json['questions'] as List)
          .map((q) => QuestionModel.fromJson(q))
          .toList(),
      isValid: json['isValid'] ?? false,
      isOnline: json['isOnline'] ?? true,
    );
  }

  // ToJson method for OnlineExamModel
  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'questionsNumber': noOfQuestions,
      'questions': question.map((q) => q.toJson()).toList(),
    //  'isValid': isValid,
    };
  }

  // Initial method for OnlineExamModel
  factory OnlineExamModel.initial() {
    return OnlineExamModel(
      examTitle: '',
      courseCode: '',
      examDate: DateTime.now(),
      examDuration: const Duration(minutes: 0),
      question: [],
      isValid: false,
      isOnline: true,
      totalMark: 0
    );
  }
}

// OfflineExamModel extends BaseExamModel
class OfflineExamModel extends BaseExamModel {
  final String location;

  OfflineExamModel({
    required String examTitle,
    required String courseCode,
    required DateTime examDate,
    required Duration examDuration,

    required int totalMark,
    required this.location,
    bool isOnline = false,
  }) : super(
    examTitle: examTitle,
    courseCode: courseCode,
    examDate: examDate,
    examDuration: examDuration,
    isOnline: isOnline,
    totalMark: totalMark,

  );

  // CopyWith method for OfflineExamModel
  @override
  OfflineExamModel copyWith({
    String? examTitle,
    String? courseCode,
    DateTime? examDate,
    Duration? examDuration,
    String? location,
    bool? isOnline,
    int? totalMark
  }) {
    return OfflineExamModel(
      examTitle: examTitle ?? this.examTitle,
      courseCode: courseCode ?? this.courseCode,
      examDate: examDate ?? this.examDate,
      examDuration: examDuration ?? this.examDuration,
      location: location ?? this.location,
      isOnline: isOnline ?? this.isOnline,
      totalMark: totalMark?? this.totalMark

    );
  }

  // FromJson method for OfflineExamModel
  factory OfflineExamModel.fromJson(Map<String, dynamic> json) {
    return OfflineExamModel(
      examTitle: json['examTitle'],
      courseCode: json['courseCode'],
      examDate: DateTime.parse(json['startTime']),
      examDuration: Duration(minutes: json['durationInMin']),
      location: json['location'] ?? 'NULL',
      isOnline: json['isOnline'] ?? false,
      totalMark: json['totalMarks'],
    );
  }

  // ToJson method for OfflineExamModel
  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'locationExam': location,
    };
  }

  // Initial method for OfflineExamModel
  factory OfflineExamModel.initial() {
    return OfflineExamModel(
      examTitle: '',
      courseCode: '',
      examDate: DateTime.now(),
      examDuration: const Duration(minutes: 0),
      location: '',
      isOnline: false,
      totalMark: 0
    );
  }
}









// OfflineExamModel extends BaseExamModel
class PDFExamModel extends BaseExamModel {
  final String program;
  final String level;
  final String semester;
  final String timeInHour;
  final List<QuestionModel> questions;
 final  bool isValid;

  PDFExamModel( {
  this.isValid = false,
    required String examTitle,
    required String courseCode,
    required DateTime examDate,
    required Duration examDuration,
    required int totalMark,
     required this.program,
    required this.semester,
    required this.level,
    required this.questions,
    required this.timeInHour,
    bool isOnline = false,
  }) : super(
    examTitle: examTitle,
    courseCode: courseCode,
    examDate: examDate,
    examDuration: examDuration,
    isOnline: isOnline,
    totalMark: totalMark
  );

  // CopyWith method for OfflineExamModel
  @override
  PDFExamModel copyWith({
    String? examTitle,
    String? courseCode,
    DateTime? examDate,
    Duration? examDuration,
    String? location,
    bool? isOnline,
    int? totalMark,
    String? program,
    String? level,
    String? semester,
    String? timeInHour,
    bool? isValid,
    List<QuestionModel>? questions
  }) {
    return PDFExamModel(
      examTitle: examTitle ?? this.examTitle,
      courseCode: courseCode ?? this.courseCode,
      examDate: examDate ?? this.examDate,
      examDuration: examDuration ?? this.examDuration,
      isOnline: isOnline ?? this.isOnline,
      totalMark: totalMark?? this.totalMark,
      semester: semester?? this.semester,
      program: program?? this.program,
      level: level?? this.level,
      questions: questions?? this.questions,
        timeInHour: timeInHour?? this.timeInHour,
        isValid:  isValid?? this.isValid
    );
  }

  // Initial method for OfflineExamModel
  factory PDFExamModel.initial() {
    return PDFExamModel(
      examTitle: '',
      courseCode: '',
      examDate: DateTime.now(),
      examDuration: const Duration(minutes: 0),
      isOnline: false,
      totalMark: 0,
      level: '',
      program: '',
      semester: '',
      timeInHour: '',
      isValid: false,
      questions: []
    );
  }
}