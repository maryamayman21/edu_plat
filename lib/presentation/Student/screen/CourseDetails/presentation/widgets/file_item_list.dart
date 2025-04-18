
import 'dart:io';

import 'package:edu_platt/core/utils/helper_methds/parse_url_method.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/domain/entities/course_details_entity.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
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
              if (isImage(file.extension)) {
                Navigator.pushNamed(context, AppRouters.imageViewerScreen,
                    arguments: {'imageUrl': parseUrl(file.path), 'imageName': file.name});
              }
              else if(isVideo(file.extension)){
                Navigator.pushNamed(context, AppRouters.videoViewerScreen,
                    arguments: {'videoUrl':parseUrl(file.path), 'videoName': file.name});
              }
              else{
                Navigator.pushNamed(context, AppRouters.pdfViewerScreen,
                    arguments: {'pdfUrl': parseUrl(file.path), 'pdfName': file.name});
              }
            },
            child: ListTile(
              leading: isImage(file.extension)
                  ? Text('Image')
              // ClipRRect(
              //   ///TODO::REFACTOR
              //   borderRadius: BorderRadius.circular(10.r),
              //   child: Image.file(
              //     File(file.path!),
              //     width: 50.w,
              //     height: 50.h,
              //     fit: BoxFit.cover,
              //   ),
              // )
                  : isVideo(file.extension)
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
  bool isImage(String extension){
    return extension =='.png' || extension =='.jpg' || extension =='.jpeg';
  }
  bool isVideo(String extension){
    return extension =='.mp4' || extension =='.mov';
  }
}
