

class DoctorCoursesRequest{
  final String courseCode;

  DoctorCoursesRequest( { required this.courseCode,});

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
    };
  }


}