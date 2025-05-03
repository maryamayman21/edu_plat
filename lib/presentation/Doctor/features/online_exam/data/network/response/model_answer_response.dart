import 'package:edu_platt/core/network/base_response.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/domain/entity/model_answer.dart';

class ModelAnswerResponse extends BaseResponse {
  final List<ModelAnswerEntity> modelAnswerEntity;

  ModelAnswerResponse({
    required super.status,
    required super.message,
    required this.modelAnswerEntity,
  });

  factory ModelAnswerResponse.fromJson(Map<String, dynamic> json) {
    return ModelAnswerResponse(
      status: json['status'],
      message: json['message'],
      modelAnswerEntity: (json['modelAnswer'] as List)
          .map((e) => ModelAnswerEntity.fromJson(e))
          .toList(),
    );
  }

  // @override
  // Map<String, dynamic> toJson() {
  //   return {
  //     'status': status,
  //     'message': message,
  //     'modelAnswer': modelAnswerEntity.map((e) => e.toJson()).toList(),
  //   };
  // }
}
