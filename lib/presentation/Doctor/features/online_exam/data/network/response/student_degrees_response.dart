import 'package:edu_platt/core/network/base_response.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/domain/entity/student_degree_entity.dart';

class StudentDegreesResponse extends BaseResponse {
 final List<StudentDegreeEntity> studentDegreeEntity;

 StudentDegreesResponse({
  required this.studentDegreeEntity,
  required bool status,
  required String message,
 }) : super(
  status: status,
  message: message,
 );

 // Convert JSON to StudentDegreesResponse
 factory StudentDegreesResponse.fromJson(Map<String, dynamic> json) {
  return StudentDegreesResponse(
   // Deserialize the list of StudentDegreeEntity objects
   studentDegreeEntity: (json['students'] as List)
       .map((item) => StudentDegreeEntity.fromJson(item))
       .toList(),
   status: json['success'],
   message: json['message'],
  );
 }

 // Convert StudentDegreesResponse to JSON
 @override
 Map<String, dynamic> toJson() {
  return {
   ...super.toJson(), // Include fields from BaseResponse
   // Serialize the list of StudentDegreeEntity objects
   'students': studentDegreeEntity.map((item) => item.toJson()).toList(),
  };
 }
}