

import 'package:edu_platt/core/network/base_response.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/domain/entities/course_details_entity.dart';

class FetchFileResponse extends BaseResponse {
  final List<CourseDetailsEntity>? courses;

  FetchFileResponse({ required status , required message ,required this.courses}) :super(status: status, message: message);

  factory FetchFileResponse.fromJson(Map<String, dynamic> json, String type) {
    return FetchFileResponse(
      status: json['success'],
      message: json['message'],
      courses: (json['materials'] as List?)?.map((e) => CourseDetailsEntity.fromJson(e)).toList(),

    );

  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'courseDetails': courses?.map((e) => e.toJson()).toList(),
    };
  }


}
