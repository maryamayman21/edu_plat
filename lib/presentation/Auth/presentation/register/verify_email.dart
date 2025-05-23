import 'package:edu_platt/presentation/sharedWidget/buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/Assets/appAssets.dart';
import '../../../../core/utils/Color/color.dart';
import '../../../Routes/custom_AppRoutes.dart';
import '../../cubit/auth_cubit.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/web_services/auth_web_service.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key, required this.arguemnt, });
 final  List<String> arguemnt;

  @override
  State<VerifyEmail> createState() => _VerifypasswordState();
}

class _VerifypasswordState extends State<VerifyEmail> {
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
        create: (context) => AuthCubit(AuthRepository(AuthWebService())),
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
           //   if(state.message == "Email verified successfully and user created.") {
                ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                      content:
                      Text(state.message)),
                );
                Navigator.pushReplacementNamed(
                    context, AppRouters.loginStudentRoute , arguments: false);
            //  }
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 64.h),
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
                  Text('We sent a reset code to ${widget.arguemnt[1]}',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            // fontSize: 22.sp
                          )),
                  Text('Enter 5 digit code that mentioned in the email',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            // fontSize: 22.sp
                          )),
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
                          //print(code);
                        });
                      }, // end onSubmit
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return Padding(
                        padding: REdgeInsets.only(top: 30, bottom: 10),
                        child: CustomButtonWidget(
                            onPressed: state is AuthLoading
                                ? (){}
                                : () {
                              if (code != null && code.length == 5) {
                                BlocProvider.of<AuthCubit>(context)
                                    .verifyEmail(code,widget.arguemnt[1] );
                              }
                            },
                            child: state is AuthLoading?
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Verify Email', style: TextStyle(
                                    color: Colors.white , fontSize: 20
                                ),),
                                SizedBox(width: 15,),
                                SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ): const Text('Verify Email', style: TextStyle(
                                color: Colors.white , fontSize: 20
                            ),)
            
                        ),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Haven\'t got the email yet?',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 16.sp,
                              color: Colors.black)),
                      BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                       return TextButton(
                        onPressed: state is AuthLoading
                            ? null
                            : () {
            
                            print(widget.arguemnt[0]); print(widget.arguemnt[1]); print(widget.arguemnt[2]); print(widget.arguemnt[3]);
                            print('Done');
                            BlocProvider.of<AuthCubit>(context)
                                .register(widget.arguemnt[0] ,widget.arguemnt[1] , widget.arguemnt[2] , widget.arguemnt[3]);
                            print('Done');
            
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
