import 'package:dartz/dartz.dart';
import 'package:edu_platt/core/network/failure.dart';
import 'package:edu_platt/presentation/courses/data/network/requests/delete_course_request.dart';
import 'package:edu_platt/presentation/courses/domain/entity/course_entity.dart';

abstract class CoursesRepo{

  Future<Either<Failure, List<CourseEntity>>> fetchCourses();
  Future<Either<Failure, String>> deleteCourse(DeleteCourseRequest request);

}