

import 'package:dartz/dartz.dart';
import 'package:edu_platt/core/network/failure.dart';
import 'package:edu_platt/presentation/profile_update/data/network/requests/add_profilepic_request.dart';
import 'package:edu_platt/presentation/profile_update/data/network/requests/update_phone_number_request.dart';
import 'package:edu_platt/presentation/profile_update/domain/entity/user_entity.dart';

abstract class ProfileRepo {
  Future<Either<Failure, UserEntity>>fetchUserProfile();
  Future<Either<Failure, String?>>fetchPhoneNumber();
  Future<Either<Failure, String?>>fetchProfilePicture();
  Future<Either<Failure, String>>uploadProfilePicture(UploadProfilePicRequest request );
  Future<Either<Failure, String>>updatePhoneNumber(UpdatePhoneNumberRequest request  );
}