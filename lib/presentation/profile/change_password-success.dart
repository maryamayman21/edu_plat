import 'package:edu_platt/core/cashe/services/course_cashe_service.dart';
import 'package:edu_platt/core/cashe/services/notes_cache_service.dart';
import 'package:edu_platt/core/cashe/services/profile_cashe_service.dart';
import 'package:edu_platt/core/file_picker/file_picker_service.dart';
import 'package:edu_platt/presentation/Auth/presentation/loginStudent/loginStudent.dart';
import 'package:edu_platt/presentation/Auth/service/token_service.dart';
import 'package:edu_platt/presentation/profile/cubit/profile_cubit.dart';
import 'package:edu_platt/presentation/profile/data/profile_web_services.dart';
import 'package:edu_platt/presentation/profile/repository/profile_repository.dart';
import 'package:edu_platt/presentation/sharedWidget/buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/Assets/appAssets.dart';


import '../Routes/custom_AppRoutes.dart';
import '../sharedWidget/Student_Doctor.dart';


class ChangePasswordSuccess extends StatelessWidget {
  const ChangePasswordSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>

           ProfileCubit(profileRepository:  ProfileRepository(ProfileWebServices()), tokenService: TokenService(), filePickerService:FilePickerService(), profileCacheService: ProfileCacheService(), notesCacheService: NotesCacheService(), courseCacheService: CourseCacheService()   ),
     // ProfileCubit(ProfileRepository(ProfileWebServices())  ),
      child: Scaffold(
          body: Padding(
        padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 16.w),
        child: Column(
          children: <Widget>[
            const Spacer(
              flex: 2,
            ),
            Image.asset(AppAssets.passwordSuccess),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Successful',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(
              height: 32.h,
            ),
            Text(
              'Congratulations! Your password has been changed. Click continue to login.',
              //    maxLines: 2,
              textWidthBasis: TextWidthBasis.longestLine,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.grey, fontSize: 18.sp),
            ),
            SizedBox(
              height: 64.h,
            ),
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                final cubit = context.read<ProfileCubit>();

                return CustomButtonWidget(
                    child: Text(
                      'Continue',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontFamily: 'Roboto-Mono'),
                    ),
                    onPressed: () {
                      cubit.logout();
                      // After the password change, when the user presses "Continue"
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreenStudent()),
                            (Route<dynamic> route) => false, // This removes all previous routes from the stack
                      );

                    });
              },
            ),
            const Spacer(
              flex: 3,
            ),
          ],
        ),
      )),
    );
  }
}
