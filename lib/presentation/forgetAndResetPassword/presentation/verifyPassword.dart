import 'package:edu_platt/presentation/sharedWidget/buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/Assets/appAssets.dart';
import '../../../core/utils/Color/color.dart';
import '../../Routes/custom_AppRoutes.dart';
import '../cubit/forget_pass_cubit.dart';
import '../data/repository/repository.dart';
import '../data/web_services/web_services.dart';

class Verifypassword extends StatefulWidget {
  const Verifypassword({super.key, required this.userEmail});
  final String userEmail;
  @override
  State<Verifypassword> createState() => _VerifypasswordState();
}

class _VerifypasswordState extends State<Verifypassword> {
  String code = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Image.asset(
          AppAssets.logo,
          height: 60.h,
        ),
        centerTitle: true,
        toolbarHeight: 60.0,
        // leading: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back_ios))
      ),
      body: BlocProvider(
        create: (context) =>
            ForgetPassCubit(ForgetPassRepository(ForgetPassWebService())),
        child: BlocListener<ForgetPassCubit, ForgetPassState>(
          listener: (context, state) {
            if (state is ForgetPassSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );

            }
              else if(state is OTPVerifiedSuccess){
              Navigator.pushReplacementNamed(
                  context,
                  AppRouters.setPassword,
                  arguments: widget.userEmail
              );
            }
            else if (state is ForgetPassFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 64.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Check your email',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 22.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'We sent a reset code to ${widget.userEmail}',
                  ),
                  const Text(
                    'Enter 5 digit code that mentioned in the email',
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: OtpTextField(
                      fieldWidth: 60.w,
              
                      numberOfFields: 5,
                      borderWidth: 1,
                      borderColor: color.primaryColor,
                      //set to true to show as box or false to show as dash
                      showFieldAsBox: true,
                      //runs when a code is typed in
                      onCodeChanged: (String code) {
                        //handle validation or checks here
                      },
                      //runs when every textfield is filled
                      onSubmit: (String verificationCode) {
                        setState(() {
                          code = verificationCode;
                        });
                      }, // end onSubmit
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  BlocBuilder<ForgetPassCubit, ForgetPassState>(
                      builder: (context, state) {
                        return Padding(
                          padding: EdgeInsets.only(top: 30.h, bottom: 10.h),
                          child: SizedBox(
                            width: double.infinity, // Makes button take full width
                            child: CustomButtonWidget(
                              onPressed: state is ForgetPassLoading
                                  ? () {}
                                  : () {
                                if (code != null && code.length == 5) {
                                  BlocProvider.of<ForgetPassCubit>(context)
                                      .verifyEmail(code, widget.userEmail);
                                }
                              },
                              child: state is ForgetPassLoading
                                  ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Verify Email',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.sp, // Responsive font size
                                    ),
                                  ),
                                  // SizedBox(width: 15.w), // Responsive width
                                  // SizedBox(
                                  //   height: 15.h, // Responsive height
                                  //   width: 15.w, // Responsive width
                                  //   child: CircularProgressIndicator(
                                  //     color: Colors.white,
                                  //     strokeWidth: 2.w, // Responsive stroke width
                                  //   ),
                                  // ),
                                ],
                              )
                                  : Text(
                                'Verify Email',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp, // Responsive font size
                                ),
                              ),
                            ),
                          ),
                        );
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Haven\'t got the email yet?',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 16.sp,
                              color: Colors.black)),
                      BlocBuilder<ForgetPassCubit, ForgetPassState>(
                        builder: (context, state) {
                          return TextButton(
                            onPressed: state is ForgetPassLoading
                                ? null
                                : () {
                                    BlocProvider.of<ForgetPassCubit>(context)
                                        .forgetPassword(widget.userEmail);
                                  },
                            child: Text('Resend code',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16.sp,
                                        color: color.primaryColor)),
                          );
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
