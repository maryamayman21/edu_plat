import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:edu_platt/presentation/Student/screen/levels/widgets/level_widget.dart';
import 'package:edu_platt/presentation/courses/domain/entity/course_entity.dart';
import 'package:edu_platt/presentation/courses/presentaion/widgets/courses_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class StudentSuccessWidget extends StatelessWidget {
  const StudentSuccessWidget({super.key, required this.courses});
  final List<CourseEntity> courses;
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Padding(
        padding: REdgeInsets.only(top: 40.0.h),
        child: Column(
          children: [
            SizedBox(
              height: 240.h,
              width: 400.w,
              child: const LevelWidget(),
            ),
            SizedBox(height: 25.h,),
            Padding(
              padding: const EdgeInsets.symmetric( horizontal: 30,vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [color.primaryColor, Colors.grey],
                      tileMode: TileMode.clamp,
                    ).createShader(bounds),
                    child: const Text(
                      'Courses',
                      style: TextStyle(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        //Navigation to view all screen
                        Navigator.pushNamed(context, AppRouters.studentViewAllCoursesRoute,
                       arguments: courses
                        );

                      }, child: const Text('View all'))
                ],
              ),
            ),
            CoursesGrid(
              page:AppRouters.doctorCoursesScreen,  //-> to show doctor for this course
              courses: courses.take(2).toList(),
            ),
          // StudentCoursesListview()
          ],
        ),
      ),
    );
  }
}
