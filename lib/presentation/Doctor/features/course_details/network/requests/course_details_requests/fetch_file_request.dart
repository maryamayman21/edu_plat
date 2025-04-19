class FetchFileRequest{
  final String type;
  final String courseCode;
  FetchFileRequest({required this.type, required this.courseCode});

  factory FetchFileRequest.fromJson(Map<String, dynamic> json) {
    return FetchFileRequest(
      type: json['type'],
      courseCode: json['courseCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'courseCode': courseCode,
    };
  }


}