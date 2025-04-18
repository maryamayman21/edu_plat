class CourseCardEntity {
  final String courseDescription;
  final int creditHours;
  final int noOfLectures;
  final String doctorName;
  final Map<String, dynamic> grading;

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
      creditHours: json['courseCreditHours'],
      noOfLectures: json['lectureCount'],
      grading:  json['grading'] as Map<String, dynamic>
    );
  }



  Map<String, dynamic> toJson() {
    return {
      'doctorName': doctorName,
      'courseDescription': courseDescription,
      'creditHours': creditHours,
      'noOfLectures': noOfLectures,
      'grading': grading
    };
  }
}
