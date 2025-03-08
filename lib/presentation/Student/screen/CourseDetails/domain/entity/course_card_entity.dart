class CourseCardEntity {
  final String courseDescription;
  final int creditHours;
  final int noOfLectures;
  final String doctorName;
  final List<Map<String, int>> grading;

  CourseCardEntity(
      this.doctorName,
      {
        required this.courseDescription,
        required this.creditHours,
        required this.noOfLectures,
        required this.grading,
      }
      );

  factory CourseCardEntity.fromJson(Map<String, dynamic> json) {
    return CourseCardEntity(
      json['doctorName'],
      courseDescription: json['courseDescription'],
      creditHours: json['creditHours'],
      noOfLectures: json['noOfLectures'],
      grading: List<Map<String, int>>.from(
          (json['grading'] as List).map((e) => Map<String, int>.from(e))
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doctorName': doctorName,
      'courseDescription': courseDescription,
      'creditHours': creditHours,
      'noOfLectures': noOfLectures,
      'grading': grading.map((e) => Map<String, int>.from(e)).toList(),
    };
  }
}
