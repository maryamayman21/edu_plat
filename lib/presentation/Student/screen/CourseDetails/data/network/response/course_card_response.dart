

import 'package:edu_platt/core/network/base_response.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/domain/entity/course_card_entity.dart';


class CourseCardResponse extends BaseResponse {
  final CourseCardEntity courseCardEntity;

  CourseCardResponse({
    required status,
    required message,
    required this.courseCardEntity,
  }) : super(status: status, message: message);

  factory CourseCardResponse.fromJson(Map<String, dynamic> json) {
    return CourseCardResponse(
      status: json['success'],
      message: json['message'],
      courseCardEntity: CourseCardEntity.fromJson(json['courseCardEntity']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': status,
      'message': message,
      'courseCardEntity': courseCardEntity.toJson(),
    };
  }
}


