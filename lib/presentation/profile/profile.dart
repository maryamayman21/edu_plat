import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:edu_platt/core/cashe/services/course_cashe_service.dart';
import 'package:edu_platt/core/cashe/services/notes_cache_service.dart';
import 'package:edu_platt/core/cashe/services/profile_cashe_service.dart';
import 'package:edu_platt/core/file_picker/file_picker_service.dart';
import 'package:edu_platt/presentation/Auth/service/token_service.dart';
import 'package:edu_platt/presentation/notification/presentation/cubit/notification_counter_cubit.dart';
import 'package:edu_platt/presentation/profile/cubit/phone_cubit.dart';
import 'package:edu_platt/presentation/profile/cubit/profile_cubit.dart';
import 'package:edu_platt/presentation/profile/cubit/profile_photo_cubit.dart';
import 'package:edu_platt/presentation/profile/data/profile_web_services.dart';
import 'package:edu_platt/presentation/profile/model/user.dart';
import 'package:edu_platt/presentation/profile/profileField.dart';
import 'package:edu_platt/presentation/profile/repository/profile_repository.dart';
import 'package:edu_platt/presentation/profile/shimmer_effect.dart';
import 'package:edu_platt/services/push_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/utils/Assets/appAssets.dart';
import '../../core/utils/Color/color.dart';
import '../../core/utils/Strings/string.dart';
import '../../core/utils/customDialogs/custom_dialog.dart';

import '../Routes/appRouts.dart';
import '../Routes/custom_AppRoutes.dart';


class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileView();
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 20.w),
              child: Column(
                children: [
                  BlocProvider(
                    create: (context) => ProfilePhotoCubit(
                        profileRepository:
                            ProfileRepository(ProfileWebServices()),
                        tokenService: TokenService(),
                        filePickerService: FilePickerService(),
                        profileCacheService: ProfileCacheService(),
                    )
                      ..fetchProfilePhoto(), // Initialize cubit and load cached photo
                    child: BlocListener<ProfilePhotoCubit, ProfilePhotoState>(
  listener: (context, state) {

    if (state is ProfilePhotoFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(state.errorMessage)),
      );
    }

  },
  child: BlocBuilder<ProfilePhotoCubit, ProfilePhotoState>(
                      builder: (context, state) {
                        String? photo;
                        final cubit = context.read<ProfilePhotoCubit>();
                        if (state is ProfilePhotoSuccess) {
                          photo = state.photo;
                        }
                        if (state is ProfilePhotoFailure) {
                          print(state.errorMessage);
                          // return const SizedBox.shrink();
                        }
                        return Container(
                          height: 200.h,
                          width: 200.w,
                          decoration: BoxDecoration(
                            image: state is ProfilePhotoLoading
                                ? null
                                : DecorationImage(
                                    image: photo != null
                                        ? MemoryImage(base64Decode(photo))
                                        : const AssetImage(
                                            AppAssets.defaultProfile),
                                    fit: BoxFit.fill,
                                  ),
                            color: const Color(0xffE6E6E6),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              GestureDetector(
                                onTap: () => cubit.selectPhoto(),
                                child: Container(
                                  margin: EdgeInsets.all(8.r),
                                  decoration: const BoxDecoration(),
                                  child: Icon(
                                    Icons.add_a_photo_rounded,
                                    color: const Color(0xff615e5e),
                                    size: 30.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
),
                  ),
                  SizedBox(height: 20.h),
                  BlocProvider(
                    create: (context) => ProfileCubit(
                        profileRepository:
                            ProfileRepository(ProfileWebServices()),
                        tokenService: TokenService(),
                        filePickerService: FilePickerService(),
                        profileCacheService: ProfileCacheService(),
                      courseCacheService: CourseCacheService(),
                      notesCacheService: NotesCacheService()
                    )
                      ..getProfileData(), // Initialize cubit and load cached photo

                    child: BlocListener<ProfileCubit, ProfileState>(
                      listener: (context, state) {
                        if(state is LogOutSuccess){
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRouters.studentOrDoctor,
                            (route) => true,
                          );
                        }
                        if (state is ProfileError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(
                                content: Text(state.errorMessage)),
                          );
                        }
                      },
                      child: BlocBuilder<ProfileCubit, ProfileState>(
                          builder: (context, state) {
                        UserModel? user;
                        if (state is ProfileLoaded) {
                          user = state.userModel;
                        }
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20.w),
                            child: Column(
                              children: [
                                state is ProfileLoading
                                    ? ShimmerWidget()
                                    : Profilefield(
                                        title: "Name",
                                        value: user?.userName ?? " ",
                                        isEditable: false,
                                      ),
                                state is ProfileLoading
                                    ? ShimmerWidget()
                                    : Profilefield(
                                        title: "Email",
                                        value: user?.email ?? " ",
                                        isEditable: false,
                                      ),
                                Profilefield(
                                  title: "Program",
                                  value: "Computer Science",
                                  isEditable: false,
                                ),
                                BlocProvider(
                                  create: (context) => PhoneCubit(
                                      profileRepository: ProfileRepository(
                                          ProfileWebServices()),
                                      tokenService: TokenService(),
                                      profileCacheService:
                                          ProfileCacheService())
                                    ..fetchPhoneNumber(), // Initialize cubit and load cached photo
                                  child: BlocListener<PhoneCubit, PhoneState>(
  listener: (context, state) {
    // TODO: implement listener
    if (state is PhoneNumberFailure){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('No internet connection')),
      );
    }
  },
  child: BlocBuilder<PhoneCubit, PhoneState>(
                                    builder: (context, state) {
                                      String? phoneNumber;
                                      if (state is PhoneNumberSuccess) {
                                        phoneNumber = state.phoneNumber;
                                        print(
                                            "Phone number in UI $phoneNumber");
                                      }
                                      if (state is PhoneNumberFailure) {
                                        print(state.errorMessage);
                                      }
                                      if (state is PhoneNumberLoading) {
                                        phoneNumber = "";
                                      }
                                      return Profilefield(
                                        title: "Mobile number",
                                        value: '1007848603',
                                        isEditable: true,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 0.h),
                                          child: IntlPhoneField(
                                              controller: context
                                                  .read<PhoneCubit>()
                                                  .phoneController,
                                              decoration: InputDecoration(
                                                labelStyle: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Colors.black),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.r),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                                counterText: "",
                                              ),
                                              dropdownTextStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              initialCountryCode: 'EG',
                                              onSubmitted: (phone) {
                                                context
                                                    .read<PhoneCubit>()
                                                    .updatePhoneNumber(phone);
                                              },
                                              onCountryChanged: (country) {},

                                              ///TODO : TEST
                                              initialValue: phoneNumber ?? ""),
                                        ),
                                      );
                                    },
                                  ),
),
                                ),
                                SizedBox(height: 20.h),
                                InkWell(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Change Password",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                                color: Colors.black,
                                                fontSize: 18.sp),
                                      ),
                                      const Icon(Icons.chevron_right),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        AppRouters.changePasswordRoute,
                                     arguments: user!.email
                                    );
                                  },
                                ),
                                SizedBox(height: 20.h),
                                ElevatedButton(
                                  onPressed: () async {
                                    bool? result = await CustomDialogs
                                        .showConfirmationDialog(
                                      context: context,
                                      title: "",
                                      content:
                                          "Are you sure you want to log out?",
                                      confirmText: "Yes",
                                      cancelText: "No",
                                      imageUrl: AppAssets.logout,
                                    );
                                    if (result == true) {
                                      context.read<ProfileCubit>().close();
                                      context.read<ProfileCubit>().clearUponUserType();
                                      // context.read<PhoneCubit>().close();
                                      context.read<ProfileCubit>().logout();
                                      PushNotificationsService.onNewNotification = () {
                                        context.read<NotificationCounterCubit>().reset();
                                      };
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        AppRouters.studentOrDoctor,
                                            (route) => false,
                                      );
                                    }
                                    //  context.read<ProfilePhotoCubit>().close();


                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: color.primaryColor,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 130.w, vertical: 15.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25).r,
                                    ),
                                  ),
                                  child: Text(
                                    "Logout",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                            color: Colors.white,
                                            fontSize: 17.sp),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ))),
    );
  }
}
