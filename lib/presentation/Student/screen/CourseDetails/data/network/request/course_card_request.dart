
class CourseCardRequest{
  final String courseCode;
  final String doctorId;
  CourseCardRequest( { required this.courseCode, required this.doctorId,});

  // factory FetchFileRequest.fromJson(Map<String, dynamic> json) {
  //   return FetchFileRequest(
  //     type: json['type'],
  //     courseCode: json['courseCode'],
  //     doctorId: json,
  //   );
  // }

  Map<String, dynamic> toJson() {
    return {
      'courseCode': courseCode,
      'userId' : doctorId
    };
  }


}