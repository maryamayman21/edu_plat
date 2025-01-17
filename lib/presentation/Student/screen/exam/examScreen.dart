import 'package:edu_platt/core/utils/Assets/appAssets.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Routes/custom_AppRoutes.dart';

class Examscreen extends StatefulWidget {
  const Examscreen({super.key});

  @override
  State<Examscreen> createState() => _ExamscreenState();
}

class _ExamscreenState extends State<Examscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppAssets.onboarding3),
          Text(
            "Prepare yourself to test your knowledge. Click on 'Start Exam' to begin.",
            style: TextStyle(
              fontSize: 18.sp,
              color: color.primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 80.h,
          ),
          Padding(
            padding: REdgeInsets.only(left: 110, right: 110),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, AppRouters.ExamDetails);
              },
              child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                    color: color.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    border: Border.all(color: Colors.grey, width: 3.0.w)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.arrow_right_alt,
                      color: Colors.white,
                      size: 40.sp,
                    ),
                    Text(
                      "Start Exam",
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
