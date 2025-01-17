
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({super.key, this.onPressed, required this.child});
  final void Function()? onPressed;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return  MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.r))) ,
        color:color.primaryColor,
        minWidth: double.infinity,
        onPressed: onPressed,
        child:Padding(
          padding:  EdgeInsets.symmetric(vertical: 16.h, horizontal: 28.w),
          child: child

        )
    );
  }
}

