
class FetchFileRequest{
  final String type;
  final String courseCode;
  final String doctorId;
  FetchFileRequest( {required this.type, required this.courseCode, required this.doctorId,});

  // factory FetchFileRequest.fromJson(Map<String, dynamic> json) {
  //   return FetchFileRequest(
  //     type: json['type'],
  //     courseCode: json['courseCode'],
  //     doctorId: json,
  //   );
  // }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'courseCode': courseCode,
      'userId' : doctorId
    };
  }


}