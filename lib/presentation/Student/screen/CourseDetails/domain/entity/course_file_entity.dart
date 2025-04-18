

class CourseFileEntity {
  final String name;
  final String path;
  final String size;
  final String extension;
  final String date;
  //final String? type;
  //int? id;
  //String courseCode;

  CourseFileEntity(
      {required this.name,
        required this.path,
        required this.size,
        required this.extension,
        required this.date,

      });

  factory CourseFileEntity.fromJson(Map<String, dynamic> json) {
    return CourseFileEntity(
        name: json['fileName'],
        path: json['filePath'],
        size: json['size'],
        extension:  json['fileExtension'],
        date: json['uploadDate'],

    );
  }

}
