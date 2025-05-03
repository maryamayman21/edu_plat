import 'package:edu_platt/core/network/base_response.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/question_model.dart';

class FetchExamQuestionsResponse extends BaseResponse {
  final QuestionModel questionModel;

  FetchExamQuestionsResponse({
    required String message,
    required bool success,
    required this.questionModel,
  }) : super(status: success, message: message);

  // Convert a FetchExamQuestionsResponse instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'success': status,
      'questionModel': questionModel.toJson(),
    };
  }

  // Create a FetchExamQuestionsResponse instance from a JSON map
  factory FetchExamQuestionsResponse.fromJson(Map<String, dynamic> json) {
    return FetchExamQuestionsResponse(
      message: json['message'],
      success: json['success'],
      questionModel: QuestionModel.fromJson(json['questionModel']),
    );
  }
}