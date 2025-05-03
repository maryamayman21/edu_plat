import 'package:edu_platt/core/network/base_response.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/exam_model.dart';


//for update exam

class UpdateOfflineExamResponse extends BaseResponse{

  final OfflineExamModel exam;

  UpdateOfflineExamResponse({ required bool status, required String message  , required this.exam}): super(message: message , status: status);

  factory UpdateOfflineExamResponse.fromJson(Map<String, dynamic> json) {
    return UpdateOfflineExamResponse(
      message: json['message'],
      status:json['success'] ,
      exam: OfflineExamModel.fromJson(json['examView']),
    );
  }


}