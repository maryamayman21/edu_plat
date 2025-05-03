import 'package:edu_platt/core/constant/constant.dart';
import 'package:edu_platt/presentation/Student/screen/home/domain/entity/file_entity.dart';

class FileModel extends FileEntity {
  FileModel({required super.fileName, required super.filePath});

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      fileName: json['fileName'] as String,
      filePath:'${ ApiConstants.baseUrl}${json['filePath']}',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fileName': fileName,
      'filePath': filePath,
    };
  }
}
