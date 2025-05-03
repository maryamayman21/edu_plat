
import 'package:edu_platt/core/network/base_response.dart';

class CreateExamResponse extends BaseResponse{
   CreateExamResponse({required String message, required bool status})
: super(message: message, status: status);


   // Create object from JSON
   factory CreateExamResponse.fromJson(Map<String, dynamic> json) {
     return CreateExamResponse(
       message: json['message'],
       status: json['success'],
     );
   }


}