
import 'package:edu_platt/core/network/base_response.dart';

class UploadProfilePicResponse extends BaseResponse{

   UploadProfilePicResponse({required status, required message,}):
   super(status: status, message: message);

   factory   UploadProfilePicResponse.fromJson(Map<String, dynamic> json) {
     return   UploadProfilePicResponse(
         status: json['success'],
         message: json['message'],
     );
   }


}