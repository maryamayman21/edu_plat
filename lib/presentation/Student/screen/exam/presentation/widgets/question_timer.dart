import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionTimer extends StatelessWidget {
  const QuestionTimer({
    super.key,
    required this.questionData,
    required this.iconData,
    required this.questionText,
  });

  final String questionData;
  final IconData iconData;
  final String questionText;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate responsive dimensions based on screen width
        final maxWidth = constraints.maxWidth;
        final containerWidth = maxWidth > 600 ? 180.w : 150.w;
        final containerHeight = maxWidth > 600 ? 140.w : 120.w;

        return Container(
          width: containerWidth,
          height: containerHeight,
          constraints: BoxConstraints(
            minWidth: 120.w, // Minimum width to prevent too small on small devices
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.white.withOpacity(0.5),
              width: 2.w,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  Icon(
                  iconData,
                  color: Colors.white,
                  size: 30.sp,
                ),
                SizedBox(width: 8.w), // Using .w for consistency
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(
                  questionData,
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
              Text(
                questionText,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 2,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
              ],
            ),
            ],
          ),
        ),
        ),
        ),
        );
      },
    );
  }
}