import 'package:edu_platt/core/network/base_response.dart';

class UpdatePhoneNumberResponse extends BaseResponse{


  UpdatePhoneNumberResponse({required status, required message,}):
  super(message: message , status:  status);


  factory UpdatePhoneNumberResponse.fromJson(Map<String, dynamic> json) {
    return UpdatePhoneNumberResponse(
      status: json['success'] as bool,
      message: json['message'] as String,
    );
  }

}