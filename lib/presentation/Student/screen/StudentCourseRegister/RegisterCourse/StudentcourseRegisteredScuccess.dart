
import 'package:edu_platt/core/utils/Assets/appAssets.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:edu_platt/presentation/sharedWidget/buttons/custom_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentCourseregisteredscuccess extends StatelessWidget {
  const StudentCourseregisteredscuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric( horizontal:  16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Image.asset(AppAssets.successMark,
             ),
             SizedBox(
               height: 32.h,
             ),
             Text('Courses have been registered successfully.',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontFamily: 'Roboto-Mono',
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 23.sp
              ),

            ),
            SizedBox(
              height: 64.h,
            ),
            CustomButtonWidget(
              child: Text('Back to home',
                style:  TextStyle(
                    color: Colors.white, fontSize: 20.sp
                    , fontFamily: 'Roboto-Mono'
                ),
              ),
              onPressed: (){
                Navigator.pushReplacementNamed(context, AppRouters.HomeStudent);
              },
            ),
          ],
        ),
      ),
    );
  }
}
