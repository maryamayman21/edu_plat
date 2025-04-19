import 'dart:io';

import 'package:edu_platt/presentation/Doctor/features/course_details/domain/entities/course_details_entity.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../file_preview.dart';

class FileListWidget extends StatelessWidget {
  final List<CourseDetailsEntity> courseDetailsEntity;
  final void Function(int index) onDeleteFile;
  final void Function(int index) onUpdateFile;
  final String courseCode;

  const FileListWidget({
    super.key,
    required this.courseDetailsEntity,
    required this.onDeleteFile,
    required this.onUpdateFile, required this.courseCode,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          final file = courseDetailsEntity[index];
          return InkWell(
            onTap: () {
              if (isImage(file.extention!)) {
                Navigator.pushNamed(context, AppRouters.imageViewerScreen,
                    arguments: {'imageUrl': file.path, 'imageName': file.name});
              }
              else if(isVideo(file.extention!)){
                Navigator.pushNamed(context, AppRouters.videoViewerScreen,
                    arguments: {'videoUrl': file.path, 'videoName': file.name});
              }
              else{
                Navigator.pushNamed(context, AppRouters.pdfViewerScreen,
                    arguments: {'pdfUrl': file.path, 'pdfName': file.name});
              }
            },
            child: ListTile(
              leading: isImage(file.extention!)
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.file(
                  File(file.path!),
                  width: 50.w,
                  height: 50.h,
                  fit: BoxFit.cover,
                ),
              )
                  : isVideo(file.extention!)
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
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, size: 24.sp),
                    onPressed: () {
                      onUpdateFile(index);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red, size: 24.sp),
                    onPressed: () {
                      onDeleteFile(index);
                    },
                  ),
                ],
              ),
            ),
          );
        },
        childCount: courseDetailsEntity.length,
      ),
    );
  }
  bool isImage(String extension){
    return extension =='png' || extension =='jpg' || extension =='jpeg';
  }
  bool isVideo(String extension){
    return extension =='mp4' || extension =='mov';
  }
}
