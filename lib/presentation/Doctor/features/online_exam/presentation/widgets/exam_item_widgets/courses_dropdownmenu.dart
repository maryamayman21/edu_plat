import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseDropdown extends StatelessWidget {
  final List<String> courses;
  final String selectedCourse;
  final void Function(String selectedCourse)? onCourseSelected;

  const CourseDropdown({
    super.key,
    required this.courses,
    required this.selectedCourse,
    this.onCourseSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 25.w,vertical: 10.h),
      child: DropdownButtonFormField<String>(
        value: courses.contains(selectedCourse) ? selectedCourse : null,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
            fontStyle: FontStyle.italic,
          ),
          labelStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).primaryColor.withOpacity(0.9),
            fontStyle: FontStyle.italic,
          ),
          labelText: 'Select Course',
          filled: true,
          fillColor: Colors.grey.shade200,
          hintText: 'Select Course',
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade200,
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade200,
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade200,
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a course';
          }
          return null;
        },
        items: courses.map((course) {
          return DropdownMenuItem<String>(
            value: course,
            child: Text(course),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            onCourseSelected?.call(value);
          }
        },
      ),
    );
  }
}
