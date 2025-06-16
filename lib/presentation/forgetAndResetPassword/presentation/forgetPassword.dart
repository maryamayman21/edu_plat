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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,

          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  AppBar(
                    title: Image.asset(
                      AppAssets.logo,
                      height: 60.h,
                      fit: BoxFit.contain,
                    ),
                    centerTitle: true,
                    toolbarHeight: 60.h,
                    automaticallyImplyLeading: false,
                  ),
                  Expanded(
                    child: BlocProvider(
                      create: (context) =>
                          ForgetPassCubit(ForgetPassRepository(ForgetPassWebService())),
                      child: BlocListener<ForgetPassCubit, ForgetPassState>(
                        listener: (context, state) {
                          if (state is ForgetPassSuccess) {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRouters.verifyPassword,
                              arguments: emailController.text,
                            );
                          } else if (state is ForgetPassFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.error)),
                            );
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 32.h,
                          ),
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Forget Password',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                    color: color.primaryColor,
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  'Please enter your email to reset password.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  'Your Email',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                    color: color.primaryColor,
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                CustomTextfield(
                                  controller: emailController,
                                  validator: isEmailValide,
                                  label: 'Email',
                                  hintText: 'Enter your email address',
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                SizedBox(height: 15.h),
                                BlocBuilder<ForgetPassCubit, ForgetPassState>(
                                  builder: (context, state) {
                                    return SizedBox(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 30.h),
                                        child: CustomButtonWidget(
                                          onPressed: state is ForgetPassLoading
                                              ? () {}
                                              : () {
                                            if (formKey.currentState?.validate() == false) return;
                                            BlocProvider.of<ForgetPassCubit>(context)
                                                .forgetPassword(emailController.text.trim());
                                          },
                                          child: state is ForgetPassLoading
                                              ? Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Verify Email',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.sp,
                                                ),
                                              ),
                                              SizedBox(width: 15.w),
                                              SizedBox(
                                                height: 15.h,
                                                width: 15.w,
                                                child: const CircularProgressIndicator(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          )
                                              : Text(
                                            'Verify Email',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: 10.h),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}