import 'package:edu_platt/core/network/base_response.dart';

class FetchPhoneNumberResponse extends BaseResponse{
     final String? phoneNumber;
    FetchPhoneNumberResponse({required message , required status , required this.phoneNumber}):super(

      status: status,
      message:  message

    );
    factory FetchPhoneNumberResponse.fromJson(Map<String, dynamic> json) {
      return FetchPhoneNumberResponse(
        status: json['success'] as bool,
        message: json['message'] as String,
        phoneNumber: json['phoneNumber']
      );
    }
}