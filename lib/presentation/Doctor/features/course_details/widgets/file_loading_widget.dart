import 'dart:io';

import 'package:edu_platt/presentation/Doctor/features/course_details/domain/entities/course_details_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FileLoadingWidget extends StatelessWidget {
  const FileLoadingWidget({super.key, required this.courseDetailsEntity});
  final CourseDetailsEntity courseDetailsEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selected files',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: 21.sp,
              fontFamily: 'Roboto-Mono',
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(0, 1.h),
                  blurRadius: 3.r,
                  spreadRadius: 2.r,
                ),
              ],
            ),
            child: Row(
              children: [
                if (courseDetailsEntity.extention == 'pdf')
                  Icon(Icons.picture_as_pdf, color: Colors.red, size: 40.sp)
                else if (courseDetailsEntity.extention == 'mp4' ||
                    courseDetailsEntity.extention == 'mov')
                  Icon(Icons.video_library, color: Colors.blue, size: 40.sp)
                else
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.file(
                      File(courseDetailsEntity.path!),
                      width: 50.w,
                      height: 50.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name : ${courseDetailsEntity.name}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Size : ${(courseDetailsEntity.size)}KB',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(height: 5.h),
                      Container(
                        height: 5.h,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.green.shade50,
                        ),
                        child: const LinearProgressIndicator(value: null),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 10.w),
              ],
            ),
          ),
          SizedBox(height: 15.h),
        ],
      ),
    );
  }
}
