class StudentDegreeEntity {
  final String userName;
  final double score;
  final bool attendance;
  final double scorePercentage;

  StudentDegreeEntity({
    required this.userName,
    required this.score,
    required this.attendance,
    required this.scorePercentage,
  });

  // Convert JSON to StudentDegreeEntity
  factory StudentDegreeEntity.fromJson(Map<String, dynamic> json) {
    return StudentDegreeEntity(
      userName: json['studentName'],
      score: json['score'].toDouble(), // Ensure score is a double
      attendance: json['isAbsent'],
      scorePercentage: json['precentageExam'].toDouble(), // Ensure scorePercentage is a double
    );
  }

  // Convert StudentDegreeEntity to JSON
  Map<String, dynamic> toJson() {
    return {
      'studentName': userName,
      'score': score,
      'attendance': attendance,
      'scorePercentage': scorePercentage,
    };
  }
}