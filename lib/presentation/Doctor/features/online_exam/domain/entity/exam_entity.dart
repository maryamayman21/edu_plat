class ExamEntity{
  final String examTitle;
  final String courseCode;
  final DateTime date;
  final int duration;
  final bool isExamFinished;
  final int doctorId;
  final int examId;
  final bool isOnline;
  final String location;
  final int questionNumbers;
  final int totalMark;
  ExamEntity(this.examTitle, this.courseCode, this.date, this.duration, this.isExamFinished, this.doctorId, this.examId, this.isOnline, this.totalMark, this.location, this.questionNumbers);

  factory ExamEntity.fromJson(Map<String, dynamic> json) {
    return ExamEntity(
      json['examTitle'] as String,
      json['courseCode'] as String,
      DateTime.parse(json['startTime'] as String),
      json['durationInMin'] as int,
      json['isFinished'] as bool,
      json['doctorId'] as int,
      json['id'] as int,
      json['isOnline'] as bool,
      json['totalMarks'] as int,
      json['location'] ?? 'NULL',
      json['qusetionsNumber'] ?? 0
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'examTitle': examTitle,
      'courseCode': courseCode,
      'date': date.toIso8601String(),
      'duration': duration,
      'isExamFinished': isExamFinished,
      'doctorId': doctorId,
      'examId': examId,
      'isOnline': isOnline,
      'totalMark': totalMark,
    };
  }
}

//-> update ->