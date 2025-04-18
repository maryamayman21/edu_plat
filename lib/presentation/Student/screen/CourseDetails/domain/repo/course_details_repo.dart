


import 'package:dartz/dartz.dart';
import 'package:edu_platt/core/network/failure.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/data/network/request/course_card_request.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/data/network/request/doctor_courses_request.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/data/network/request/fetch_file_request.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/domain/entity/course_card_entity.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/domain/entity/course_file_entity.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/domain/entity/doctor_courses_entity.dart';

abstract class CourseDetailsRepo {
  Future<Either<Failure, List<CourseFileEntity>>> fetchCourseFiles(
      FetchFileRequest request);
  Future<Either<Failure, CourseCardEntity>> fetchCourseCard(
      CourseCardRequest request);
  Future<Either<Failure, List<DoctorCoursesEntity>>> fetchDoctorCourses(
      DoctorCoursesRequest request);

}