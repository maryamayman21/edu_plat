
import 'dart:io';

import 'package:edu_platt/presentation/Doctor/features/course_details/domain/entities/course_details_entity.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/domain/entity/course_file_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class FileItemList extends StatelessWidget {
  const FileItemList({super.key, required this.courseDetailsEntity});
  final List<CourseFileEntity> courseDetailsEntity;
  @override
  Widget build(BuildContext context) {
    return  SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          final file = courseDetailsEntity[index];
          return InkWell(
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>  FilePreview(fileName: file.name, filePath: file.path!, index: index , courseCode: courseCode, ) ));
            },
            child: ListTile(
              leading: file.extension == 'png' ||
                  file.extension == 'jpg' ||
                  file.extension == 'jpeg'
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.file(
                  File(file.path!),
                  width: 50.w,
                  height: 50.h,
                  fit: BoxFit.cover,
                ),
              )
                  : file.extension == 'mp4' || file.extension == 'mov'
                  ? Icon(
                Icons.video_library,
                color: Colors.blue,
                size: 40.sp,
              )
                  : Icon(
                Icons.picture_as_pdf,
                color: Colors.red,
                size: 40.sp,
              ),
              title: Text(
                file.name,
                style: TextStyle(fontSize: 16.sp),
              ),
              shape: Border.all(color: Colors.grey.shade400),
              subtitle: Text(
                'Size: ${file.size }',
                style: TextStyle(fontSize: 14.sp),
              ),

            ),
          );
        },
        childCount: courseDetailsEntity.length,
      ),
    );
  }
}
