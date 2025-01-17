import 'package:edu_platt/presentation/Doctor/features/home/presentation/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/cashe/services/course_cashe_service.dart';
import '../../../../../Routes/custom_AppRoutes.dart';
import '../../../home/presentation/widgets/search_bar.dart';
import '../../../home/presentation/widgets/sliver_appbar.dart';
import '../../application/cubit/courses_cubit.dart';
import '../widgets/courses_listView.dart';

class Viewallcourses extends StatelessWidget {
  const Viewallcourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE6E6E6),
      appBar:
      MyAppBar(title: 'All Courses', onPressed: () {
        //Navigation to Courses screen
        Navigator.pushReplacementNamed(context, AppRouters.doctorHomeRoute);
      },),


      body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 25.h),
            child: Column(
              children: [

                SizedBox(height: 15.h),
                // state is CoursesSuccess ?
                // const CustomSearchBar() :
                // SizedBox(height: 190.h),
                CoursesListview(
                  viewAll: true,
                  page: AppRouters.doctorCourseDetailsRoute,),
              ],
            ),
          )
      ),
    );
  }
}

