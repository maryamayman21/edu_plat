
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:edu_platt/core/network/failure.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/network/requests/course_details_requests/fetch_file_request.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/network/requests/course_details_requests/update_file_request.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/network/requests/course_details_requests/upload_file_request.dart';

import '../entities/course_details_entity.dart';

abstract class CourseDetailsRepo {
  Future<Either<Failure, List<CourseDetailsEntity>>> fetchCourseFiles(
    FetchFileRequest request);
  Future<Either<Failure, List<CourseDetailsEntity>>> saveCoursesFiles(
      UploadFileRequest request);
  Future<Either<Failure, List<CourseDetailsEntity>>> deleteCoursesFile(
      int index , String type, String courseCode);
  Future<Either<Failure, List<CourseDetailsEntity>>> updateCoursesFile(
      int index, String type , File file , String courseCode);
  Future<Either<Failure, File >> downloadFile(
      String filePath, String fileName, int index );
}