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
  factory CourseDetailsEntity.initial() {
    return CourseDetailsEntity(
      name: "",               // Default empty string
      path: "",               // Default empty string
      size: '',                // Default 0
      extention: "",          // Default empty string
      date: '',   // Default current time (or use a fixed date)
      type: "",               // Default empty string
      id: 0,                 // Default empty string
      courseCode: "",         // Default empty string
    );
  }


  // Factory constructor that handles null
  factory CourseDetailsEntity.fromJson(Map<String, dynamic>? json) {
    return json != null
        ? CourseDetailsEntity._fromJson(json)
        : CourseDetailsEntity.initial();
  }

  // Private constructor for actual parsing
  factory CourseDetailsEntity._fromJson(Map<String, dynamic> json) {
    return CourseDetailsEntity(
      name: json['fileName'] as String? ?? "",
      path: json['filePath'] as String? ?? "",
      size:  json['size'] as String? ?? "", // Handles both int/double
      extention: json['fileExtension'] as String? ?? "",
      date:  json['uploadDateFormatted'] as String? ?? "",
      type: json['typeFile'] as String? ?? "",
      id: (json['id'] as num?)?.toInt() ?? 0,
      courseCode: json['courseCode'] as String? ?? "",
    );
  }


  // factory CourseDetailsEntity.fromJson(Map<String, dynamic> json) {
  //   return CourseDetailsEntity(
  //       name: json['fileName'],
  //       type: json['typeFile'],
  //       path: json['filePath'],
  //       size: json['size'],
  //       extention:  json['fileExtension'],
  //       date: json['uploadDateFormatted'],
  //       id: json['id'],
  //     courseCode: json['courseCode']
  //   );
  // }

  Map<String, dynamic> toJson() {
    return {
      'courseCode': courseCode,
      'type': type,
      'path': path,
    };
  }

  set courseId(id) => this.id = id;


}
