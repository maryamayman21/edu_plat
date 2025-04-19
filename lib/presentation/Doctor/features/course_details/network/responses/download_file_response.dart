import 'dart:io';

import 'package:edu_platt/core/network/base_response.dart';



class DownloadFileResponse extends BaseResponse {
  File file;

  DownloadFileResponse({required bool status, required String message , required this.file})
      : super(status: status, message: message);

  // Convert object to JSON
  @override
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
    };
  }

  // Create object from JSON
  factory DownloadFileResponse.fromJson(Map<String, dynamic> json) {
    return DownloadFileResponse(
      status: json['status'],
      message: json['message'],
      file: json['file']
    );
  }
}
