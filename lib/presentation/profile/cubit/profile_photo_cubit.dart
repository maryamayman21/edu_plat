import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';


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
      emit(ProfilePhotoFailure("Failed to select photo: $e"));
    }
  }

  Future<void> _uploadAndCachePhoto(String? token, File? image, String imagebase64) async {
    try {
      await profileCacheService.saveProfilePhoto(imagebase64);
      await profileRepository.uploadProfilePhoto(token!, image);
    } catch (e) {
      emit(ProfilePhotoFailure("Failed to upload photo: $e"));
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
         print('Done');
      if (profilePhoto != null) {
        await profileCacheService.saveProfilePhoto(profilePhoto);

        print('Profile photo cached successfully');
      }
      
      if (!isClosed) emit(ProfilePhotoSuccess(profilePhoto));
      //if (!isClosed) emit(ProfilePhotoSuccess(profilePhoto));
      print('Retrieved  profile photo from server ');
    } catch (error) {
      print(error.toString());
      if (!isClosed) {
        if (error is DioError && error.response != null) {
          // Handle specific API errors
          print(error.type);
          final errorMessage =
              error.response?.data['message'] ?? 'An unexpected error occurred';
          emit(ProfilePhotoFailure(errorMessage));
        } else {
          print(error);
          emit(ProfilePhotoFailure(NetworkHandler.mapErrorToMessage(error)));
        }
      }
    }
  }

  @override
  Future<void> close(){
    print("Cubit is being closed.");
    return super.close();
  }


}
