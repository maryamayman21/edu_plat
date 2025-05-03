import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionTimer extends StatelessWidget {
  const QuestionTimer({super.key, required this.questionData, required this.iconData, required this.questionText,});

  final String questionData;
  final IconData iconData;
  final String questionText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.w, // Square width
      height: 120.w, // Square height (same as width)
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2), // Faded background
        borderRadius: BorderRadius.circular(12.r), // Slightly rounded corners
        border: Border.all(
          color: Colors.white.withOpacity(0.5), // Faded border
          width: 2.w,
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: Colors.white,
              size: 30.sp,
            ),
            SizedBox(width: 8.h),
            Text(
              "$questionData",
              style: TextStyle(
                fontSize: 28.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 2,
                    offset: Offset(1, 1),
                  )
                ],
              ),
            ),
            SizedBox(width: 8.h),
            Text(
              "$questionText",
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w500,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 2,
                    offset: Offset(1, 1),
                  )
                ],

              ),
            ),
          ],
        ),
    ),
    );
  }
}