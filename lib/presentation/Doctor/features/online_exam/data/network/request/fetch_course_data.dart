class FetchCourseDataRequest {
  final String courseCode;

  FetchCourseDataRequest({required this.courseCode});

  Map<String, dynamic> toJson() {
    return {
      'courseCode': courseCode,
    };
  }
}
