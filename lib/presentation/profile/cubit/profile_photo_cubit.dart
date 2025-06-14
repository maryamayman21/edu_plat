import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:edu_platt/core/network/failure.dart';


import '../../../core/cashe/services/profile_cashe_service.dart';
import '../../../core/file_picker/file_compression_service.dart';
import '../../../core/file_picker/file_picker_service.dart';
import '../../../core/network_handler/network_handler.dart';
import '../../Auth/service/token_service.dart';
import '../repository/profile_repository.dart';

part 'profile_photo_state.dart';

class ProfilePhotoCubit extends Cubit<ProfilePhotoState> {
  final ProfileRepository profileRepository;
  final TokenService tokenService;
  final FilePickerService filePickerService;
  final ProfileCacheService profileCacheService;
  ProfilePhotoCubit({
    required this.profileRepository,
    required this.tokenService,
    required this.filePickerService,
    required this.profileCacheService,
  }
      ) : super(ProfilePhotoInitial());


  Future<void> selectPhoto() async {
    try {
     // emit(ProfilePhotoLoading());

      final token = await tokenService.getToken();
      final File? selectedFile = await filePickerService.pickImage();

      if (selectedFile != null) {
        final List<int> fileBytes = await selectedFile.readAsBytes();
        final String base64String = base64Encode(fileBytes);


     //  final compressedUintFile =  await FileCompressionService.uintListToUintList(fileBytes);

        await _uploadAndCachePhoto(token, selectedFile, base64String);
        emit(ProfilePhotoSuccess( base64String));

         ///TODO : TEST
       // final cachedProfilePhoto = await profileCacheService.getProfilePhoto();
        // if (cachedProfilePhoto != null) {
        //
        //   emit(ProfilePhotoSuccess(cachedProfilePhoto));
        // } else {
        //   emit(ProfilePhotoFailure("Failed to retrieve cached photo."));
        // }
      }

    } catch (e) {
      emit(ProfilePhotoFailure("Failed to select photo"));
    }
  }

  Future<void> _uploadAndCachePhoto(String? token, File? image, String imagebase64) async {
    try {
      await profileRepository.uploadProfilePhoto(token!, image);
      //await profileCacheService.saveProfilePhoto(imagebase64);
    } catch (e) {
      emit(ProfilePhotoFailure("Failed to upload photo"));
       // throw Exception('"Failed to upload photo"');
    }
  }

  Future<void> fetchProfilePhoto() async {
    if(!isClosed) {
      emit(ProfilePhotoLoading());
    }
    try {
      // Try fetching from cache
      final cachedProfilePhoto = await profileCacheService.getProfilePhoto();
      if (cachedProfilePhoto != null) {
        if (!isClosed) emit(ProfilePhotoSuccess(cachedProfilePhoto));
        return;
      } else {
        print("Failed to retrieve cached profile photo.");
      }

      // Fetch from repository
      final token = await tokenService.getToken();
      String? profilePhoto = await profileRepository.fetchProfilePhoto(token!);
      if (profilePhoto != null) {
        await profileCacheService.saveProfilePhoto(profilePhoto);
      }
      
      if (!isClosed) emit(ProfilePhotoSuccess(profilePhoto));
      //if (!isClosed) emit(ProfilePhotoSuccess(profilePhoto));
    } catch (e) {
      if (e is DioError) {
        emit(ProfilePhotoFailure( ServerFailure.fromDiorError(e).message)) ;
      }
      emit(ProfilePhotoFailure(ServerFailure(e.toString()).message));
    }
  }

  @override
  Future<void> close(){
    print("Cubit is being closed.");
    return super.close();
  }


}
