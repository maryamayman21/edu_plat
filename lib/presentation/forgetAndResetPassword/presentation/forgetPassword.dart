
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/Assets/appAssets.dart';
import '../../../core/utils/validations/email_validation.dart';
import '../../Routes/custom_AppRoutes.dart';
import '../../sharedWidget/buttons/custom_button.dart';
import '../../sharedWidget/custom_textfield.dart';
import '../cubit/forget_pass_cubit.dart';
import '../data/repository/repository.dart';
import '../data/web_services/web_services.dart';
class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  TextEditingController emailController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Image.asset(AppAssets.logo, height: 60.0.h,),
              centerTitle: true,
              toolbarHeight: 60.0.h,


            ),

            body: BlocProvider(
                create: (context) =>
                    ForgetPassCubit(
                        ForgetPassRepository(ForgetPassWebService())),
                child: BlocListener<ForgetPassCubit, ForgetPassState>(
                    listener: (context, state) {
                      if (state is ForgetPassSuccess) {
                        print('Message: ${state.message}');
                        Navigator.pushReplacementNamed(
                          context, AppRouters.verifyPassword,
                         arguments:  emailController.text
                        );
                      } else if (state is ForgetPassFailure) {
                        print('Error: ${state.error}');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.error)),
                        );
                      }
                    },
                    child: Form(
                        key: formKey,
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0.w, vertical: 64.0.h),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text('Forget Password',
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                        color: color.primaryColor,
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 10.0.h,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Please enter your email to reset password.',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0.h,
                                  ),
                                  Text('Your Email',
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                        color: color.primaryColor,
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5.0.h,
                                  ),
                                  CustomTextfield(
                                    controller: emailController,
                                    validator: isEmailValide,
                                    label: 'Email',
                                    hintText: 'Enter your email address',
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  SizedBox(
                                    height: 15.0.h,
                                  ),
                                  BlocBuilder<ForgetPassCubit, ForgetPassState>(
                                      builder: (context, state) {
                                        return Padding(
                                          padding: REdgeInsets.only(
                                              top: 30, bottom: 10),
                                          child: CustomButtonWidget(
                                              onPressed: state is ForgetPassLoading
                                                  ? (){}
                                                  : () {
                                                print('Done');
                                                print(emailController.text);
                                                if (formKey.currentState
                                                    ?.validate() == false)
                                                  return;
                                                print(emailController.text);
                                                BlocProvider.of<
                                                    ForgetPassCubit>(context)
                                                    .forgetPassword(
                                                    emailController.text.trim());

                                              },
                                              child: state is ForgetPassLoading?
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
                                      }
                                  )

                                ]
                            )
                        )
                    )
                )
            )
        )
    );
  }
}

