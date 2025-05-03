import 'package:edu_platt/core/network/base_response.dart';

class DeleteExamResponse extends BaseResponse{

  DeleteExamResponse({required String message, required bool status})
      : super(message: message, status: status);


  // Create object from JSON
  factory DeleteExamResponse.fromJson(Map<String, dynamic> json) {
    return DeleteExamResponse(
      message: json['message'],
      status: json['success'],
    );
  }


}