import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseGridItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const CourseGridItem({
    super.key,
    required this.title,
    required this.onTap,
  });

  Color _getColor(String text) {
    final colors = [
      Colors.green.shade200,
     // Colors.orangeAccent.shade100,
      Colors.blue.shade400,
     // Colors.deepOrange.shade400,
    ];
    return colors[text.codeUnitAt(0) % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _getColor(title);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: backgroundColor.withOpacity(0.7),
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
