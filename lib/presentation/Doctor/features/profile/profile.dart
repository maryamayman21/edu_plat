import 'package:edu_platt/presentation/Doctor/features/profile/cubit/profilePhoto_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'dart:io';
import '../../../../core/utils/Assets/appAssets.dart';
import '../../../../core/utils/Color/color.dart';
import '../../../../core/utils/Strings/string.dart';
import '../../../../core/utils/customDialogs/custom_dialog.dart';
import '../../../Routes/custom_AppRoutes.dart';
import '../home/presentation/widgets/appBar.dart';

import 'profileField.dart';
import '../../../Routes/appRouts.dart';


class DoctorProfile extends StatelessWidget {
  const DoctorProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(),
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(title: 'Profile',onPressed: null,) ,
        body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 20.w),
          child: Column(
            children: [
              BlocBuilder<ProfileCubit, String?>(
                builder: (context, filePath) {
                  return Container(
                    height: 200.h,
                    width: 200.w,
                    decoration: BoxDecoration(
                      image: filePath != null
                          ? DecorationImage(
                        image: FileImage(File(filePath)),
                        fit: BoxFit.fill,
                      )
                          : null,
                      color: const Color(0xffE6E6E6),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<ProfileCubit>().selectPhoto();
                          },
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
              SizedBox(height: 20.h),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    children: [
                      Profilefield(
                        title: "Name",
                        value: "TokaYasien",
                        isEditable: false,
                      ),
                      Profilefield(
                        title: "Email",
                        value: "tokayasien@asu.edu.eg",
                        isEditable: false,
                      ),
                      Profilefield(
                        title: "Program  ",
                        value: "Computer Science",
                        isEditable: false,
                      ),
                      Profilefield(
                        title: "Mobile number",
                        value: "",
                        isEditable: true,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 0.h),
                          // تقليل الحشو الرأسي
                          child: IntlPhoneField(
                            decoration: InputDecoration(
                                labelStyle: TextStyle(fontSize: 14.sp),
                                // تعديل حجم النص إذا رغبت
                                border: OutlineInputBorder(
                                  // إزالة الحدود
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                counterText: ""),
                            dropdownTextStyle: TextStyle(
                              color: Colors.black, // لون كود العلم
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            initialCountryCode: 'EG',
                            onChanged: (phone) {
                             // print(phone.completeNumber);
                            },
                            onCountryChanged: (country) {
                              //print('Country changed to: ${country.name}');
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Change Password",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                  color: Colors.black, fontSize: 18.sp),
                            ),
                            const Icon(Icons.chevron_right),
                          ],
                        ),
                        onTap: () {
                          Navigator.pushNamed(context,
                              AppRouters.forgetPassword);
                        },
                      ),
                      SizedBox(height: 20.h),
                      ElevatedButton(
                        onPressed: () async {
                          bool? result = await CustomDialogs
                              .showConfirmationDialog(
                            context: context,
                            title: "",
                            content: "Are you sure Do you want to log out?",
                            confirmText: "Yes",
                            cancelText: "No",
                            imageUrl: AppAssets.logout,
                          );
                          if (result == true) {
                            Navigator.pushNamed(
                                context, AppRouters.studentOrDoctor);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color.primaryColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 130.w, vertical: 15.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius
                                .circular(25)
                                .r,
                          ),
                        ),
                        child: Text(
                          "Logout",
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: Colors.white, fontSize: 17.sp),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        ),
    );
  }
}