
import 'package:edu_platt/core/network/base_response.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/domain/entities/course_details_entity.dart';

class UploadFileResponse extends BaseResponse{

  final CourseDetailsEntity course;

  UploadFileResponse({required status, required message, required this.course}):super(status: status, message: message);


factory UploadFileResponse.fromJson(Map<String, dynamic> json) {
  return UploadFileResponse(
    status: json['success'],
    message: json['message'],
    course: CourseDetailsEntity.fromJson(json['fileDetails'])
  );
}

@override
Map<String, dynamic> toJson() {
  return {
    'success': status,
    'message': message,
  };
}



}