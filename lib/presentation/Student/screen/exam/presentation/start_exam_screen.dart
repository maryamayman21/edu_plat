import 'package:edu_platt/core/utils/Assets/appAssets.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/exam_model.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/model/student_exam_model.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/model/submit_exam_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Routes/custom_AppRoutes.dart';

class StartExamScreen extends StatefulWidget {
  const StartExamScreen({super.key, required this.exam});
  final StudentExamModel exam;

  @override
  State<StartExamScreen> createState() => _StartExamScreenState();
}

class _StartExamScreenState extends State<StartExamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Top Image
              SizedBox(
                height: 200.h,
                child: Image.asset(AppAssets.onboarding3),
              ),
              SizedBox(height: 32.h),

              // Instructions
              _buildInstruction("Make sure you have a stable internet connection."),
              _buildInstruction("You are permitted to take the exam only once."),
              _buildInstruction("Prepare yourself to test your knowledge. Click on 'Start Exam' to begin."),
              SizedBox(height: 60.h),

              // Start Exam Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: REdgeInsets.symmetric(vertical: 14),
                    backgroundColor: color.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: Colors.grey, width: 2.w),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      AppRouters.studentQuizScreen,
                      arguments: widget.exam,
                    );
                  },
                  icon: Icon(Icons.arrow_right_alt, size: 30.sp, color: Colors.white),
                  label: Text(
                    "Start Exam",
                    style: TextStyle(fontSize: 18.sp, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInstruction(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle_outline, color: color.primaryColor, size: 20.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14.sp,
                color: color.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
