
import 'package:edu_platt/core/network/base_response.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/domain/entity/exam_entity.dart';
class GetExamsResponse extends BaseResponse {
  final List<ExamEntity> examEntity;
  GetExamsResponse({
    required super.status,
    required super.message,
    required this.examEntity,
  });

  factory GetExamsResponse.fromJson(Map<String, dynamic> json) {
    return GetExamsResponse(
      status: json['success'],
      message: json['message'],
      examEntity: (json['exams'] as List)
          .map((e) => ExamEntity.fromJson(e))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'examEntity': examEntity.map((e) => e.toJson()).toList(),
    };
  }
}
