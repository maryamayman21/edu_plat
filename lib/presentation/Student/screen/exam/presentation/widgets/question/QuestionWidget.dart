import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Questionwidget extends StatelessWidget {
  String text;

  Questionwidget({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 25.sp),
        textAlign: TextAlign.center,
      ),
    );
  }
}
