import 'package:edu_platt/core/network/base_response.dart';
import 'package:edu_platt/presentation/profile_update/data/model/user_model.dart';


class FetchUserDataResponse extends BaseResponse{
  final UserModel userModel;
    FetchUserDataResponse({required  message , required status, required this.userModel}):super(
      message:  message ,  status:  status
    );


  factory FetchUserDataResponse.fromJson(Map<String, dynamic> json) {
    return FetchUserDataResponse(
      message: json['message'] as String,
      status: json['success'] as bool,
      userModel: UserModel.fromJson(json['userProfile']),
    );
  }

}