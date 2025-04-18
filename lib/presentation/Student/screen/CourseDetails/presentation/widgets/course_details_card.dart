import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/courseDetails.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/presentation/widgets/detail_icon_text.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/presentation/widgets/table_mark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseDetailsCard extends StatelessWidget {
  final String courseTitle;
  final int creditHours;
  final int lectures;
  final String doctorName;
  final Map<String, dynamic>marks;

  const CourseDetailsCard({
    Key? key,
    required this.courseTitle,
    required this.creditHours,
    required this.lectures,
    required this.doctorName,
    required this.marks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w), // Responsive padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course Title
            Text(
            courseTitle,
              style: TextStyle(
                color: color.primaryColor,
                fontSize: 22.sp,
              ),
            ),
            SizedBox(height: 16.h), // Responsive spacing

            // First Row: Credit Hours and Lectures
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DetailIconText(
                  icon: Icons.lock_clock,
                  text: '$creditHours Credit Hours',
                ),
                DetailIconText(
                  icon: Icons.library_books,
                  text: '$lectures Lectures',
                ),
              ],
            ),
            SizedBox(height: 24.h), // Responsive spacing

            // Second Row: Grades and Chat with Doctor
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DetailIconText(
                  icon: Icons.check_circle_outline,
                  text: 'Grades',
                ),
                DetailIconText(
                  icon: Icons.chat,
                  text: 'Chat with Dr $doctorName',
                ),
              ],
            ),
            SizedBox(height: 24.h), // Responsive spacing

            // Table for Marks
            TableMark(
              marks: marks,
            ),
          ],
        ),
      ),
    );
  }
}