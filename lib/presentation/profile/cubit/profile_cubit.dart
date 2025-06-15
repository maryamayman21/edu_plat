
import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:edu_platt/core/cashe/services/course_cashe_service.dart';
import 'package:edu_platt/core/cashe/services/notes_cache_service.dart';
import 'package:edu_platt/core/network/failure.dart';
import 'package:edu_platt/core/utils/helper_methds/clear_all_notifications.dart';
import '../../../core/cashe/services/profile_cashe_service.dart';
import '../../../core/file_picker/file_picker_service.dart';
import '../../../core/localDB/secureStorage/secure_stoarge.dart';
import '../../../core/network_handler/network_handler.dart';
import '../../Auth/service/token_service.dart';
import '../model/user.dart';
import '../repository/profile_repository.dart';


part 'profile_states.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository profileRepository;
  final TokenService tokenService;
  final NotesCacheService notesCacheService;
  final FilePickerService filePickerService;
  final ProfileCacheService profileCacheService;
  final CourseCacheService courseCacheService;

  ProfileCubit({
    required this.profileRepository,
    required this.tokenService,
    required this.filePickerService,
    required this.profileCacheService,
    required this.notesCacheService,
    required this.courseCacheService
  }) : super(ProfileInitial());

  Future<void> getProfileData() async {
    try {
      if (!isClosed) {
        emit(ProfileLoading());
      }
      final token = await tokenService.getToken();
      final cachedData = await profileCacheService.getProfile();
      if (cachedData != null) {
        if (!isClosed) {
          emit(ProfileLoaded(UserModel.fromJson(cachedData)));
          return;
        }
      }
      final UserModel user = await profileRepository.fetchUserData(token!);
      await profileCacheService.saveProfile(user.toJson());
      if (!isClosed) {
        emit(ProfileLoaded(user));
      }
    } catch (error) {
      print(error.toString());
      if (!isClosed) {
        if (error is DioError && error.response != null) {
          print(error.type);
          // Handle specific API errors
          final errorMessage =
              error.response?.data['message'] ?? 'An unexpected error occurred';
          print(errorMessage);
        } else {
          emit(ProfileError(NetworkHandler.mapErrorToMessage(error)));
        }
      }
    }
  }

  Future<void> clearUserData() async {
    try {
      await profileCacheService.logout();
      await tokenService.clearToken();
      await tokenService.clearRole();

      if (!isClosed) {
        emit(ProfileInitial());
      } else {
        print("ProfileCubit is closed. Skipping state emission.");
      }
    } catch (e) {
      if (!isClosed) {
        emit(ProfileError(NetworkHandler.mapErrorToMessage(e)));
      } else {
        print("ProfileCubit is closed. Skipping error state emission.");
      }
    }
  }




  Future<void> logout() async {

    try {
      // if (!isClosed) {
      //   emit(ProfileLoading());
      // }
      final token = await tokenService.getToken();
      await profileRepository.logout(token!);

      await clearAllNotifications();
      await clearUserData();
      await  profileCacheService.clearProfileCache();
      await  profileCacheService.clearPhoneNumberCache();
      await  profileCacheService.clearProfilePhotoCache();
      emit(LogOutSuccess());
    } catch (error) {
      print(error.toString());
      if (!isClosed) {
        if (error is DioError) {
          // Handle specific API errors
          emit(LogoutError(ServerFailure.fromDiorError(error).message));
        } else {
          emit(LogoutError(ServerFailure(error.toString()).message));
        }
      }
    }
  }

  Future<void> clearNotesCache()async{
    print('Notes cache deleted');
    await notesCacheService.clearNotesCache();
  }
  // Future<void> clearCoursesCache()async{
  //   print('Courses cache deleted');
  //   await courseCacheService.clearCoursesCache();
  // }

  Future<void> clearUponUserType()async{
    String? role = await tokenService.getRule();
    if(role== 'Student'){
      await clearNotesCache();
      //  await clearCoursesCache();
    }else{
      //   await clearCoursesCache();
    }
  }


  @override
  Future<void> close(){
    print("Cubit is being closed.");
    return super.close();
  }

}