import 'package:edu_platt/presentation/courses/domain/entity/course_entity.dart';

class CourseModel extends CourseEntity {
  CourseModel({
    required super.courseCode,
    required super.hasLab,
  });

  // Deserialize from JSON
  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      courseCode: json['courseCode'] as String,
      hasLab: json['has_Lab'] as bool,
    );
  }

  // Serialize to JSON
  Map<String, dynamic> toJson() {
    return {
      'courseCode': courseCode,
      'has_Lab': hasLab,
    };
  }
}
