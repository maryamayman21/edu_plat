
import 'package:edu_platt/core/network/base_response.dart';
import 'package:edu_platt/presentation/courses/data/model/course_model.dart';

class FetchCoursesResponse extends BaseResponse {
  final List<CourseModel> courses;

  FetchCoursesResponse({
    required String message,
    required bool success,
    required this.courses,
  }) : super(
    message: message,
    status: success,
  );

  factory FetchCoursesResponse.fromJson(Map<String, dynamic> json) {
    return FetchCoursesResponse(
      message: json['message'] ?? '',
      success: json['success'] ?? false,
      courses: (json['courses'] as List<dynamic>?)
          ?.map((item) => CourseModel.fromJson(item))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'success': status,
      'courses': courses.map((course) => course.toJson()).toList(),
    };
  }

}
