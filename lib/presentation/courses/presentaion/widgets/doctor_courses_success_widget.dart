import 'package:edu_platt/core/utils/Assets/appAssets.dart';

import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:edu_platt/presentation/courses/domain/entity/course_entity.dart';
import 'package:edu_platt/presentation/courses/presentaion/widgets/courses_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class DoctorCoursesSuccessWidget extends StatelessWidget {
  const DoctorCoursesSuccessWidget({super.key, required this.courses});
  final List<CourseEntity> courses;
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 15.h),
          Container(
            height: 200,
            width: 400,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppAssets.doctorImage), fit: BoxFit.fill)),
          ),
          //course
          Padding(
            padding: const EdgeInsets.symmetric( horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Courses',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontSize: 22,
                      fontFamily: 'Roboto-Mono'
                  ),
                ),
                TextButton(
                    onPressed: () {
                      //Navigation to view all screen
                      Navigator.pushNamed(context, AppRouters.doctorViewAllCoursesRoute,
                          arguments: courses
                      );

                    }, child: const Text('View all'))
              ],
            ),
          ),
           CoursesGrid(
            page:AppRouters.doctorCourseDetailsRoute,
            courses: courses.take(2).toList(),
          ),
       //   CoursesListview( page: AppRouters.doctorCourseDetailsRoute,)
        ],
      ),
    );
  }
}
