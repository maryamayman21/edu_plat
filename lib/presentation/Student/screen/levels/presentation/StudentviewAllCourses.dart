import 'package:edu_platt/presentation/Doctor/features/home/presentation/widgets/appBar.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:edu_platt/presentation/Student/screen/levels/presentation/Studentcourses_listView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentViewallcourses extends StatelessWidget {
  const StudentViewallcourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE6E6E6),
      appBar:
      MyAppBar(title: 'All Courses', onPressed: () {
        //Navigation to Courses screen
        Navigator.pushReplacementNamed(context, AppRouters.HomeStudent);
      },),


      body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 25.h),
            child: Column(
              children: [

                SizedBox(height: 15.h),
                StudentCoursesListview(
                  viewAll: true,
                  page: AppRouters.studentCourseDetailsRoute,),
              ],
            ),
          )
      ),
    );
  }
}

