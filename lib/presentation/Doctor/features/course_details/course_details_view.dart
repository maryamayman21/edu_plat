
import 'package:edu_platt/presentation/Doctor/features/course_details/widgets/course_details_view_body.dart';
import 'package:flutter/material.dart';
class CourseDetails extends StatelessWidget {
  const CourseDetails({super.key, required this.courseCode});
  final String courseCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:CourseDetailsViewBody(courseCode: courseCode,)
    );
  }
}



