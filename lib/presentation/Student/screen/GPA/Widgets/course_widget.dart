import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseWidget extends StatelessWidget {
  IconData icon;
  String text;
  final VoidCallback? onTap;
   CourseWidget({required this.icon,required this.text,this.onTap,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: REdgeInsets.all(15.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon,color: color.secondColor, size: 35.sp),
                SizedBox(width: 8.w),
                Text(text,style: TextStyle(color:color.primaryColor,fontSize: 20.sp,fontWeight: FontWeight.bold ),)
              ],
            ),
          ),
        )
    );
  }
}
