import 'package:edu_platt/core/network/base_response.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/model/student_exam_model.dart';


class StartExamResponse extends BaseResponse {
  final StudentExamModel? exam;

  StartExamResponse({
    required String message,
    required bool success,
    required this.exam,
  }) : super(status: success, message: message);

  // Convert a FetchExamQuestionsResponse instance to a JSON map
  // Map<String, dynamic> toJson() {
  //   return {
  //     'message': message,
  //     'success': status,
  //     'examStatusCode': questionModel.toJson(),
  //   };
  // }

  // Create a FetchExamQuestionsResponse instance from a JSON map
  factory StartExamResponse.fromJson(Map<String, dynamic> json) {
    return StartExamResponse(
      message: json['message'] ?? 'Exam fetched successfully',
      success: json['success'],
      exam:  json['exam'] == Null ? StudentExamModel.init():StudentExamModel.fromJson(json['exam']), ///TODO:: TEST
    );
  }
}