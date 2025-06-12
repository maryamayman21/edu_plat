import 'package:edu_platt/presentation/Doctor/features/online_exam/domain/entity/exam_entity.dart';

class StudentExamCardEntity extends ExamEntity {
  final int? score;
  final int? percentage;
  final bool attended;

  StudentExamCardEntity({
    required String examTitle,
    required String courseCode,
    required DateTime date,
    required int duration,
    required bool isExamFinished,
    required int doctorId,
    required int examId,
    required bool isOnline,
    required int totalMark,
    required String location,
    required int questionNumbers,
    this.score,
    this.percentage,
    required this.attended,
  }) : super(
    examTitle,
    courseCode,
    date,
    duration,
    isExamFinished,
    doctorId,
    examId,
    isOnline,
    totalMark,
    location,
    questionNumbers,
  );

  // Convert a FinishedExamCardEntity instance to a JSON map
  // @override
  // Map<String, dynamic> toJson() {
  //   return {
  //     'examTitle': examTitle,
  //     'courseCode': courseCode,
  //     'date': date.toIso8601String(),
  //     'duration': duration,
  //     'isExamFinished': isExamFinished,
  //     'doctorId': doctorId,
  //     'examId': examId,
  //     'isOnline': isOnline,
  //     'totalMarks': totalMark,
  //     'location': location,
  //     'questionsNumber': questionNumbers,
  //     'score': score,
  //     'percentage': percentage,
  //     'attended': attended,
  //   };
  // }

  // Create a FinishedExamCardEntity instance from a JSON map
  factory StudentExamCardEntity.fromJson(Map<String, dynamic> json) {
    return StudentExamCardEntity(
      examTitle: json['examTitle']??'null',
      courseCode: json['courseCode']??'NULL',
      date:DateTime.parse(json['startTime']),
      duration: json['durationInMin']??0,
      isExamFinished: json['isFinished']??false,
     doctorId: json['doctorId'] ?? 0,
      examId: json['id']??0,
      isOnline: json['isOnline']??false,
      totalMark: json['totalMarks']??0,
      location: json['location']?? 'NULL',
      questionNumbers: json['qusetionsNumber'],
      score: json['score'] as int,
      percentage: json['percentageExam'] as int ,
      attended: json['isAbsent'] ?? true,
    );
  }
}