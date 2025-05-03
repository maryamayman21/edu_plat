
import 'package:edu_platt/core/network/base_response.dart';

class UpdateExamResponse extends BaseResponse{
  UpdateExamResponse({required String message, required bool status})
      : super(message: message, status: status);


  // Create object from JSON
  factory UpdateExamResponse.fromJson(Map<String, dynamic> json) {
    return UpdateExamResponse(
      message: json['message'],
      status: json['success'],
    );
  }


}