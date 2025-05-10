import 'package:edu_platt/core/network/base_response.dart';

class FetchProfilePicResponse extends BaseResponse{
 final String? pic;

  FetchProfilePicResponse({  required message , required status  ,required this.pic}):
 super(status: status , message: message);

 factory FetchProfilePicResponse.fromJson(Map<String, dynamic> json) {
   return FetchProfilePicResponse(
     message: json['message'] as String,
     status: json['success'] as bool,
     pic: json['profilephoto'] as String?, // Allows null values safely
   );
 }



}