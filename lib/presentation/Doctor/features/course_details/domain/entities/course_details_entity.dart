import 'dart:io';

import 'package:hive/hive.dart';
part 'course_details_entity.g.dart';

@HiveType(typeId: 0)
class CourseDetailsEntity {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String? path;
  @HiveField(2)
  final String size;
  @HiveField(3)
  final String? extention;
  @HiveField(4)
  final String? date;
  @HiveField(5)
  final String? type;
  @HiveField(6)
   int? id;
  @HiveField(7)
  String courseCode;

  CourseDetailsEntity(
      {required this.name,
        required this.path,
        required this.size,
        required this.extention,
        required this.date,
        required  this.type,
        required  this.id,
        required  this.courseCode,

      });

  factory CourseDetailsEntity.fromJson(Map<String, dynamic> json) {
    return CourseDetailsEntity(
        name: json['fileName'],
        type: json['typeFile'],
        path: json['filePath'],
        size: json['size'],
        extention:  json['fileExtension'],
        date: json['uploadDateFormatted'],
        id: json['id'],
      courseCode: json['courseCode']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'courseCode': courseCode,
      'type': type,
      'path': path,
    };
  }

  set courseId(id) => this.id = id;


}
