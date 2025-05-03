import 'package:dartz/dartz.dart';
import 'package:edu_platt/core/network/failure.dart';
import 'package:edu_platt/presentation/Student/screen/home/data/request/student_help_file_request.dart';
import 'package:edu_platt/presentation/Student/screen/home/domain/entity/file_entity.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<FileEntity>>> fetchFile(
      StudentHelpFileRequest request);
}