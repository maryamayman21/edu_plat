import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Doctor/features/home/presentation/widgets/search_bar.dart';
import 'package:edu_platt/presentation/Student/screen/levels/widgets/student_courses_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../Routes/custom_AppRoutes.dart';

class Level1 extends StatefulWidget {
  const Level1({super.key, required this.levelNumber});
  final String levelNumber;
  @override
  State<Level1> createState() => _Level1State();
}

class _Level1State extends State<Level1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE6E6E6),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: Container(
          decoration: BoxDecoration(
            color: color.primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, AppRouters.HomeStudent);
                },
                icon: Padding(
                  padding: REdgeInsets.all(5.0),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                )),
            title: Text(
              widget.levelNumber,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 25.sp, color: Colors.white),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 25.h),
            child: Column(
              children: [
                const CustomSearchBar(),
                SizedBox(height: 15.h),
                StudentCoursesGrid(
                  page:  AppRouters.studentCourseDetails,
                ),
              ],
            ),
          )),
    );
  }
}
