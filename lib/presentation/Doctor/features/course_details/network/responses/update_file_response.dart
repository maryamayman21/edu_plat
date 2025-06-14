

import 'package:edu_platt/core/network/base_response.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/domain/entities/course_details_entity.dart';

class UpdateFileResponse extends BaseResponse{

  final CourseDetailsEntity course;

  UpdateFileResponse({ required status , required message   ,required this.course})
      :super(status:  status , message:  message);

 factory UpdateFileResponse.fromJson(Map<String, dynamic> json) {
   return UpdateFileResponse(
       status: json['success'],
       message: json['message'],
     course: CourseDetailsEntity.fromJson(json['fileDetails'])
   );
 }

 // @override
 // Map<String, dynamic> toJson() {
 //   return {
 //     'status': status,
 //     'message': message,
 //     'updatedFilePath': updatedFilePath,
 //   };
 // }



}