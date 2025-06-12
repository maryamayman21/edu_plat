import 'package:edu_platt/core/network/base_response.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/course_data_model.dart';

class FetchCourseDataResponse extends BaseResponse {
  final CourseDataModel courseDataModel;

  FetchCourseDataResponse({
    required bool status,
    required String message,
    required this.courseDataModel,
  }):super(message: message, status: status);

  factory FetchCourseDataResponse.fromJson(Map<String, dynamic> json) {
    return FetchCourseDataResponse(
      status: json['success'] as bool,
      message: json['message'] as String,
      courseDataModel: CourseDataModel.fromJson(json['examDetails']),
    );
  }
}
