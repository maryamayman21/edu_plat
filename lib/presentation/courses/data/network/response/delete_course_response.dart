import 'package:edu_platt/core/network/base_response.dart';

class DeleteCourseResponse extends BaseResponse {
  DeleteCourseResponse({required String message, required bool success})
      : super(status: success, message: message);

  factory DeleteCourseResponse.fromJson(Map<String, dynamic> json) {
    return DeleteCourseResponse(
      message: json['message'] ?? '',
      success: json['success'] ?? false,
    );
  }
}
