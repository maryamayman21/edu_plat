import 'dart:io';

import 'package:dio/dio.dart';

class UploadFileRequest {
  final File? file;
  final String? type;
  final String courseCode;

  UploadFileRequest(
      {required this.file, required this.type, required this.courseCode});
  factory UploadFileRequest.fromJson(Map<String, dynamic> json) {
    return UploadFileRequest(
      file: json['file'] != null ? File(json['file']) : null,
      type: json['type'],
      courseCode: json['courseCode'],
    );
  }
 ///TODO::TEST HERE
  Future<FormData> toFormData()async{
    if (file == null || !File(file!.path).existsSync()){
      throw Exception('File does not exist');
    }
    print('Print got here inside formData');
    FormData formData = FormData.fromMap({
      'File':  await MultipartFile.fromFile(file!.path, filename: file!.path.split('/').last),
      'Type': type,
      'CourseCode': courseCode,
    });
    return formData;
  }
}
