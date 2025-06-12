import 'package:edu_platt/core/network/base_response.dart';
import 'package:edu_platt/presentation/Student/screen/exam/domain/entity/exam_card_entity.dart';

class FetchExamsResponse extends BaseResponse {
  final List<StudentExamCardEntity> finishedExamCardEntity;

  FetchExamsResponse({
    required String message,
    required bool success,
    required this.finishedExamCardEntity,
  }) : super(message: message, status: success);

  // Convert a FetchExamsResponse instance to a JSON map
  @override
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'success': status,
      'finishedExamCardEntity': finishedExamCardEntity.map((e) => e.toJson()).toList(),
    };
  }

  // Create a FetchExamsResponse instance from a JSON map
  factory FetchExamsResponse.fromJson(Map<String, dynamic> json) {
   print(json.toString());

    return FetchExamsResponse(
      message: json['message'],
      success: json['success'],
      finishedExamCardEntity: (json['exams'] as List<dynamic>)
          .map((e) => StudentExamCardEntity.fromJson(e))
          .toList(),
    );
  }
}
