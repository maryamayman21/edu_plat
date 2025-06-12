import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.onPressed,
    required this.text,
    this.backgroundColor,
    this.foregroundColor,
    this.iconData,
  });

  final void Function()? onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? Theme.of(context).primaryColor,
      elevation: 2,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: onPressed,
        splashColor: Colors.white24,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: foregroundColor ?? Colors.white,
                ),
              ),
              if (iconData != null) ...[
                SizedBox(width: 10.w),
                Icon(
                  iconData,
                  size: 20.sp,
                  color: foregroundColor ?? Colors.white,
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
