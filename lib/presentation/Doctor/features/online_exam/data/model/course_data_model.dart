import 'package:edu_platt/presentation/Doctor/features/online_exam/domain/entity/course_data_entity.dart';

class CourseDataModel extends CourseDataEntity {
  CourseDataModel({
    required String courseTitle,
    required String program,
    required int examDuration,
    required int semester,
    required int level,
    required int totalMark,
    required String courseCode
  }) : super(
    courseTitle: courseTitle,
    program: program,
    examDuration: examDuration,
    semester: semester,
    level: level,
    totalMark: totalMark,
    courseCode: courseCode
  );

  factory CourseDataModel.fromJson(Map<String, dynamic> json) {
    return CourseDataModel(
      courseTitle: json['title'] as String,
      program: json['program'] as String,
      examDuration: json['time'] as int,
      semester: json['semester'] as int,
      level: json['level'] as int,
      totalMark: json['totalMarks'] as int,
      courseCode: json['courseCode'] as String
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'courseTitle': courseTitle,
      'program': program,
      'examDuration': examDuration,
      'semester': semester,
      'level': level,
      'totalMark': totalMark,
    };
  }
}
