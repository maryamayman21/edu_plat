

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailIconText extends StatelessWidget {
  final IconData icon;
  final String text;

  DetailIconText({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.blue,
        ),
         SizedBox(width: 8.w),
        Text(
          text,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 15.sp,
          ),
        ),
      ],
    );
  }
}
