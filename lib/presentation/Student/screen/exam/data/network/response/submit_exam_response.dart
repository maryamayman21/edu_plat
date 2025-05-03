import 'package:edu_platt/core/network/base_response.dart';

class SubmitExamResponse extends BaseResponse {
  SubmitExamResponse({required String message, required bool success})
      : super(message: message, status: success);

  factory SubmitExamResponse.fromJson(Map<String, dynamic> json) {
    return SubmitExamResponse(
      message: json['message'] ?? '',
      success: json['success'] ?? false,
    );
  }
}
