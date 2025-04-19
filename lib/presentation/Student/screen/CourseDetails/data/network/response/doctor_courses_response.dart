

import 'package:edu_platt/presentation/Student/screen/CourseDetails/domain/entity/doctor_courses_entity.dart';

class DoctorCoursesResponse extends BaseResponse {
  final List<DoctorCoursesEntity>  doctorCoursesEntity;

  DoctorCoursesResponse({
    required status,
    required message,
    required this. doctorCoursesEntity,
  }) : super(status: status, message: message);

  factory DoctorCoursesResponse.fromJson(Map<String, dynamic> json) {
    return DoctorCoursesResponse(
      status: json['success'],
      message: json['message'],
      doctorCoursesEntity: (json['courseDoctors'] as List).map((e) => DoctorCoursesEntity.fromJson(e)).toList(),
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'success': status,
  //     'message': message,
  //     'courseCardEntity': courseCardEntity.toJson(),
  //   };
  // }
}


