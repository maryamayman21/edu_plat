import 'package:edu_platt/core/DataModel/courseModel.dart';
import 'package:edu_platt/core/utils/helper_methds/navigation_helper.dart';
import 'package:edu_platt/presentation/Doctor/features/courses/presentation/widgets/custom_course_item.dart';
import 'package:flutter/material.dart';

class StudentCoursesGrid extends StatelessWidget {
  StudentCoursesGrid({super.key, this.page});
  final page;

  final List<CourseModel> finalCourses = [
    CourseModel(
        courseCode: 'COMP 201',
        courseDescription: 'Design and Analysis Algorithms',
        creditHours: '3 credit hours',
        onTap: () {}),
    CourseModel(
        courseCode: 'COMP 203',
        courseDescription: 'Data Structure and Algorithms',
        creditHours: '3 credit hours',
        onTap: () {}),
    CourseModel(
        courseCode: 'COMP 205',
        courseDescription: 'Object-oriented programming',
        creditHours: '3 credit hours',
        onTap: () {}),
    CourseModel(
        courseCode: 'COMP 207',
        courseDescription: 'Database System',
        creditHours: '3 credit hours',
        onTap: () {}),
    CourseModel(
        courseCode: 'COMP 202',
        courseDescription: 'Data Structures',
        creditHours: '3 credit hours',
        onTap: () {}),
    CourseModel(
        courseCode: 'COMP 204',
        courseDescription: 'Computer Network',
        creditHours: '3 credit hours',
        onTap: () {}),
    CourseModel(
        courseCode: 'COMP 206',
        courseDescription: 'Web Programming',
        creditHours: '3 credit hours',
        onTap: () {}),
    CourseModel(
        courseCode: 'COMP 208',
        courseDescription: 'Automata',
        creditHours: '3 credit hours',
        onTap: () {}),
    CourseModel(
        courseCode: 'COMP 210',
        courseDescription: 'Graph',
        creditHours: '3 credit hours',
        onTap: () {}),
  ];


  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 8 / 7,
            mainAxisSpacing: 20,
            crossAxisSpacing: 10
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: finalCourses.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return CustomCourseItem(
            onTap: () {
              selectedCourse(
                  context, page, finalCourses[index].courseCode);
            },
            onDelete: () {
            },
            courseCode: finalCourses[index].courseCode,
            showDeleteIcon: false,

          );

          // return
        },
      ),
    );
  }
}
