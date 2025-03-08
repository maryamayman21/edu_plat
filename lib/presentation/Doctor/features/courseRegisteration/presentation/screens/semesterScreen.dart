import 'package:edu_platt/core/utils/Assets/appAssets.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/sharedWidget/animated_widegt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../Routes/custom_AppRoutes.dart';

class SemesterScreen extends StatefulWidget {
  const SemesterScreen({super.key});

  @override
  State<SemesterScreen> createState() => _SemesterScreenState();
}

class _SemesterScreenState extends State<SemesterScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Reusable Animated Image Container
            AnimatedContainerWidget(
              vsync: this,
              startOffset: const Offset(0, -1),
              child: Container(
                height: 230.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: const DecorationImage(
                    image: AssetImage(AppAssets.doctorImage),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomRight: const Radius.circular(10).r,
                    bottomLeft: const Radius.circular(10).r,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 64),

            // First Semester Button
            AnimatedContainerWidget(
              vsync: this,
              startOffset: const Offset(-1, 0),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRouters.doctorCourseRegisterationRoute,
                      arguments: 1,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    shadowColor: Colors.black.withOpacity(1),
                    minimumSize: Size(100.w, 130.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10).r,
                    ),
                  ),
                  child: Text(
                    "First Semester",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: color.primaryColor,
                      fontFamily: 'Roboto-Mono',
                      shadows: [
                        Shadow(
                          color: Colors.grey.withOpacity(1),
                          offset: const Offset(2, 2),
                          blurRadius: 10.r,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 64.h),

            // Second Semester Button
            AnimatedContainerWidget(
              vsync: this,
              startOffset: const Offset(1, 0),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRouters.doctorCourseRegisterationRoute,
                      arguments: 2,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    shadowColor: Colors.black.withOpacity(1),
                    minimumSize: Size(100.w, 130.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10).r,
                    ),
                  ),
                  child: Text(
                    "Second Semester",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: color.primaryColor,
                      fontFamily: 'Roboto-Mono',
                      shadows: [
                        Shadow(
                          color: Colors.grey.withOpacity(1),
                          offset: const Offset(2, 2),
                          blurRadius: 10.r,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
