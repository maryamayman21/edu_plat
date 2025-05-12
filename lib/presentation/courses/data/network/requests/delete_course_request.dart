class DeleteCourseRequest {
  final String courseCode;

  DeleteCourseRequest({required this.courseCode});

  // Deserialize from JSON
  factory DeleteCourseRequest.fromJson(Map<String, dynamic> json) {
    return DeleteCourseRequest(
      courseCode: json['courseCode'] as String,
    );
  }

  // Serialize to JSON
  Map<String, dynamic> toJson() {
    return {
      'courseCode': courseCode,
    };
  }
}
