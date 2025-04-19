import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadFileHeader extends StatelessWidget {
  const UploadFileHeader({super.key, this.onTap});
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(14.r),
          dashPattern: [10.w, 4.w],
          strokeCap: StrokeCap.round,
          color: Colors.green.shade400,
          child: Container(
            width: double.infinity,
            height: 150.h,
            decoration: BoxDecoration(
              color: Colors.green.shade50.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.folder_open_rounded,
                  color: Colors.green,
                  size: 40.sp,
                ),
                SizedBox(height: 15.h),
                Text(
                  'Upload files',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 16.sp),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
