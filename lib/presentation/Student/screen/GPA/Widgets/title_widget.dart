import 'package:edu_platt/core/file_picker/file_compression_service.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleWidget extends StatelessWidget {
 final String text;
   TitleWidget({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
        color: Color(0xFFC1C1C1),
        border: Border.all(width: 4.w,color: Colors.white)
      ),
      child: Padding(
        padding: REdgeInsets.all(10.0),
        child: Text(text,style:TextStyle(color: color.primaryColor,fontWeight: FontWeight.bold,fontSize: 24.sp),),
      ),
    );
  }
}
