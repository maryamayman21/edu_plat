import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:edu_platt/core/network/failure.dart';
import 'package:edu_platt/core/network/internet_connection_service.dart';
import 'package:edu_platt/presentation/profile_update/data/data_source/remote_data_source.dart';
import 'package:edu_platt/presentation/profile_update/data/network/requests/add_profilepic_request.dart';
import 'package:edu_platt/presentation/profile_update/data/network/requests/update_phone_number_request.dart';
import 'package:edu_platt/presentation/profile_update/data/network/responses/add_profilepic_response.dart';
import 'package:edu_platt/presentation/profile_update/data/network/responses/fetch_phone_number_response.dart';
import 'package:edu_platt/presentation/profile_update/data/network/responses/fetch_profile_pic_response.dart';
import 'package:edu_platt/presentation/profile_update/data/network/responses/fetch_user_data_response.dart';
import 'package:edu_platt/presentation/profile_update/data/network/responses/update_phone_number_response.dart';
import 'package:edu_platt/presentation/profile_update/domain/entity/user_entity.dart';
import 'package:edu_platt/presentation/profile_update/domain/repo/profile_repo.dart';


class ProfileRepoImp implements ProfileRepo {

  final ProfileRemoteDataSource profileRemoteDataSource;
  final NetworkInfo _networkInfo;
  ProfileRepoImp(this.profileRemoteDataSource,  this._networkInfo);


  @override
  Future<Either<Failure, String?>> fetchPhoneNumber() async{
    if (await _networkInfo.isConnected) {
      try {
           final FetchPhoneNumberResponse response = await profileRemoteDataSource.fetchPhoneNumber();
             if(response.status == true){

               ///TODO:: CACHE
                return right(response.phoneNumber);

             }else{
               return left(ServerFailure(response.message ?? 'Something went wrong'));
             }

           return left(ServerFailure('Something went wrong'));
      } catch (e) {
        if (e is DioError) {
          return left(ServerFailure.fromDiorError(e));
        }
        return left(ServerFailure(e.toString()));
      }
    }
    else{
        return left(ServerFailure('No internet connection'));

      }
  }
  @override
  Future<Either<Failure, String?>> fetchProfilePicture() async{
    if (await _networkInfo.isConnected) {
      try {
        final FetchProfilePicResponse response = await profileRemoteDataSource.fetchProfilePicture();
        if(response.status == true){

          ///TODO:: CACHE

          return right(response.pic);

        }else{
          return left(ServerFailure(response.message ?? 'Something went wrong'));
        }

      } catch (e) {
        if (e is DioError) {
          return left(ServerFailure.fromDiorError(e));
        }
        return left(ServerFailure(e.toString()));
      }
    }
    else{
      return left(ServerFailure('No internet connection'));

    }
  }
  @override
  Future<Either<Failure, UserEntity>> fetchUserProfile() async{
    if (await _networkInfo.isConnected) {
      try {
        final FetchUserDataResponse response = await profileRemoteDataSource.fetchUserProfile();
        if(response.status == true){

          ///TODO:: CACHE

          return right(response.userModel);

        }else{
          return left(ServerFailure(response.message ?? 'Something went wrong'));
        }

      } catch (e) {
        if (e is DioError) {
          return left(ServerFailure.fromDiorError(e));
        }
        return left(ServerFailure(e.toString()));
      }
    }
    else{
      return left(ServerFailure('No internet connection'));

    }
  }
  @override
  Future<Either<Failure, String>> updatePhoneNumber(UpdatePhoneNumberRequest request) async{
    if (await _networkInfo.isConnected) {
      try {
        final UpdatePhoneNumberResponse response = await profileRemoteDataSource.updatePhoneNumber(request);
        if(response.status == true){

          ///TODO:: CACHE

          return right(response.message?? 'Updated successfully');

        }else{
          return left(ServerFailure(response.message ?? 'Something went wrong'));
        }

      } catch (e) {
        if (e is DioError) {
          return left(ServerFailure.fromDiorError(e));
        }
        return left(ServerFailure(e.toString()));
      }
    }
    else{
      return left(ServerFailure('No internet connection'));

    }
  }
  @override
  Future<Either<Failure, String>> uploadProfilePicture(UploadProfilePicRequest request) async{
    if (await _networkInfo.isConnected) {
      try {
        final UploadProfilePicResponse response = await profileRemoteDataSource.uploadProfilePicture(request);
        if(response.status == true){

          ///TODO:: CACHE

          return right(response.message?? 'Uploaded successfully');

        }else{
          return left(ServerFailure(response.message ?? 'Something went wrong'));
        }

      } catch (e) {
        if (e is DioError) {
          return left(ServerFailure.fromDiorError(e));
        }
        return left(ServerFailure(e.toString()));
      }
    }
    else{
      return left(ServerFailure('No internet connection'));

    }
  }



  // @override
  // Future<Either<Failure, List<CourseDetailsEntity>>> fetchCourseFiles(FetchFileRequest request)async {
  //   List<CourseDetailsEntity> coursesFiles;
  //   if (await _networkInfo.isConnected) {
  //     try {
  //       coursesFiles = await courseDetailsLocalDataSource.fetchCourseFiles(request.type, request.courseCode);
  //
  //       if(coursesFiles.isNotEmpty){
  //
  //         return right(coursesFiles);
  //       }
  //       FetchFileResponse response = await courseDetailsRemoteDataSource.fetchCourseFiles(request);
  //       if(response.status == true){
  //         // coursesFiles = getCourses(response.data , type);
  //         if(response.courses!.isNotEmpty) {
  //           print(response.courses);
  //
  //           coursesFiles =
  //           await  courseDetailsLocalDataSource.saveCourseFiles(response.courses!);
  //           return right(response.courses ?? []);
  //         }
  //         return right(response.courses ?? []);
  //
  //       }
  //
  //       //-->this case returns an empty list
  //       return left(ServerFailure('Something went wrong'));
  //
  //     } catch (e) {
  //       if (e is DioError) {
  //         return left(ServerFailure.fromDiorError(e));
  //       }
  //       return left(ServerFailure(e.toString()));
  //     }
  //   }else{
  //     try{
  //
  //       FetchFileResponse response = await courseDetailsRemoteDataSource.fetchCourseFiles(request);
  //       if(response.status == true){
  //         // coursesFiles = getCourses(response.data , type);
  //         if(response.courses!.isNotEmpty) {
  //           print(response.courses);
  //
  //           coursesFiles =
  //           await  courseDetailsLocalDataSource.saveCourseFiles(response.courses!);
  //           print('Here 2');
  //           return right(response.courses ?? []);
  //         }
  //         return right(response.courses ?? []);
  //
  //       }
  //       return left(ServerFailure('Something went wrong'));
  //     }
  //     catch(e){
  //       return left(ServerFailure('No internet connection'));
  //     }
  //   }
  // }

}