import 'package:edu_platt/core/network/base_response.dart';
import 'package:edu_platt/presentation/Student/screen/home/data/model/file_model.dart';

class StudentFileHelpResponse extends BaseResponse {
  final List<FileModel> fileModel;

  StudentFileHelpResponse({
    required super.status,
    required super.message,
    required this.fileModel,
  });

  factory StudentFileHelpResponse.fromJson(Map<String, dynamic> json) {
    return StudentFileHelpResponse(
      status: json['success'],
      message: json['message'],
      fileModel: (json['files'] as List<dynamic>)
          .map((item) => FileModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': status,
      'message': message,
      'files': fileModel.map((file) => file.toJson()).toList(),
    };
  }
}
