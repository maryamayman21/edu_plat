
import 'package:edu_platt/core/network/base_response.dart';

class DeleteFileResponse extends BaseResponse {
  DeleteFileResponse({required String message, required bool status})
      : super(message: message, status: status);

  // Convert object to JSON
  @override
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'success': status,
    };
  }

  // Create object from JSON
  factory DeleteFileResponse.fromJson(Map<String, dynamic> json) {
    return DeleteFileResponse(
      message: json['message'],
      status: json['success'],
    );
  }
}
