import 'package:edu_platt/core/network/base_response.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/exam_model.dart';


//for update exam

class UpdateOnlineExamResponse extends BaseResponse{

  final OnlineExamModel exam;

  UpdateOnlineExamResponse({ required bool status, required String message  , required this.exam}): super(message: message , status: status);

  factory UpdateOnlineExamResponse.fromJson(Map<String, dynamic> json) {
    return UpdateOnlineExamResponse(
      message: json['message'],
      status:json['success'] ,
      exam: OnlineExamModel.fromJson(json['examView']),
    );
  }


}