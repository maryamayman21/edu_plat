import 'package:edu_platt/core/utils/Assets/appAssets.dart';
import 'package:edu_platt/core/utils/validations/name_validation.dart';
import 'package:edu_platt/presentation/sharedWidget/password_textfield.dart';
import 'package:edu_platt/presentation/sharedWidget/password_visibility_cubit/confrim_password_visablity_cubit.dart';
import 'package:edu_platt/presentation/sharedWidget/password_visibility_cubit/password_visiability_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:password_strength_checker/password_strength_checker.dart';

import '../../../../core/utils/Color/color.dart';
import '../../../../core/utils/Strings/string.dart';
import '../../../../core/utils/validations/email_validation.dart';
import '../../../../core/utils/validations/password_validation.dart';
import '../../../Routes/custom_AppRoutes.dart';
import '../../../sharedWidget/buttons/custom_button.dart';
import '../../../sharedWidget/custom_textfield.dart';
import '../../cubit/auth_cubit.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/web_services/auth_web_service.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final passNotifier = ValueNotifier<PasswordStrength?>(null);

  var formKey = GlobalKey<FormState>();
  bool isPassObscure = true;
  bool isConfirmPassObscure = true;
  String confirmPassValue = '';
  String passValue = '';
  List<String> userDate = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: BlocProvider(
        create: (context) => AuthCubit(AuthRepository(AuthWebService())),
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
              );
              Navigator.pushNamed(context, AppRouters.verifyEmail , arguments:userDate);
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,

            child: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 60.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        AppAssets.logo,
                        height: 90.h,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Center(
                      child: Text(
                        Strings.makeEduPlatAcc,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 22.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Strings.signUp,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontSize: 32.sp, fontWeight: FontWeight.w700),
                      ),
                    ),
                    CustomTextfield(
                        controller: nameController,
                        label: 'Name',
                        keyboardType: TextInputType.name,
                        hintText: 'Enter your Name',
                        validator: isNameValid),
                    CustomTextfield(
                        controller: emailController,
                        label: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Enter your Email',
                        validator: isEmailValide),
                    SizedBox(height: 2.h),
                    Text(
                      'Email must ends with (@sci.asu.edu.eg)',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(height: 16.h),
                    BlocProvider(
  create: (context) =>PasswordVisiabilityCubit(),
  child: BlocBuilder< PasswordVisiabilityCubit,  PasswordVisiabilityState>(
                      builder: (context, state) {
                        bool isPasswordVisible = false;
                        IconData iconData = Icons.visibility_off;

                        if (state is PasswordVisibilityChanged) {
                          isPasswordVisible =
                              state.visibility == PasswordVisibility.visible;
                          iconData = isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off;
                        }
                        return PasswordTextfield(
                          onChanged: (value) {
                            passNotifier.value =
                                PasswordStrength.calculate(text: value);
                            passValue = value;
                            setState(() {});
                          },
                          suffixIcon: IconButton(
                            onPressed: () {
                              context
                                  .read<PasswordVisiabilityCubit>()
                                  .togglePasswordVisibility();
                            },
                            icon: Icon(iconData),
                          ),
                          validator: isPasswordValid,

                          hintText: 'Enter Password',
                          label: 'Password',
                          isObscure: !isPasswordVisible,
                        );
                      },
                    ),

),
                    SizedBox(height: 8.h),
                    Text(
                      'Password must contain at least: 1 lowercase letter, 1 uppercase letter, 1 digit, and 1 special character (!@#\$&*~).',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[700],
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),

                    SizedBox(height: 20.h),
                    PasswordStrengthChecker(
                      strength: passNotifier,
                      configuration: const PasswordStrengthCheckerConfiguration(
                        borderColor: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    BlocProvider(
  create: (context) =>ConfrimPasswordVisablityCubit(),
  child: BlocBuilder<ConfrimPasswordVisablityCubit, ConfrimPasswordVisablityState>(
                      builder: (context, state) {
                        bool isPasswordVisible = false;
                        IconData iconData = Icons.visibility_off;

                        if (state is ConfirmPasswordVisibilityChanged) {
                          isPasswordVisible =
                              state.visibility == ConfirmPasswordVisibility.visible;
                          iconData = isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off;
                        }
                        return PasswordTextfield(
                          onChanged: (value) {
                            confirmPassValue = value;
                            setState(() {});
                          },
                          suffixIcon: IconButton(
                            onPressed: () {
                              context
                                  .read<ConfrimPasswordVisablityCubit>()
                                  .togglePasswordVisibility();
                            },
                            icon: Icon(iconData),
                          ),
                          validator: (input) {
                            if (input!.trim().isEmpty || input == null) {
                              return 'Password cannot be empty';
                            }
                            if (passValue != confirmPassValue) {
                              return 'Password is not matched';
                            }
                            return null;
                          },
                          hintText: 'Confirm Password',
                          label: 'Confirm Password',
                          isObscure: !isPasswordVisible,
                          keyboardType: TextInputType.text,
                        );
                      },
                    ),
),
                    SizedBox(height: 5.h),
                    Row(children: [
                      Text(
                        passValue == confirmPassValue &&
                                passValue.isNotEmpty &&
                                confirmPassValue.isNotEmpty
                            ? 'Password is matched'
                            : '',
                        style: const TextStyle(color: Colors.black),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      passValue == confirmPassValue &&
                              passValue.isNotEmpty &&
                              confirmPassValue.isNotEmpty
                          ? const Icon(Icons.check_circle,
                              color: Color(0xFF0B6C0E))
                          : const SizedBox()
                    ]),
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return Padding(
                          padding: REdgeInsets.only(top: 30.h, bottom: 10.h),
                          child: CustomButtonWidget(
                            onPressed: state is AuthLoading
                                ? (){}
                                : () {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      confirmPassValue.trim();
                                      passValue.trim();
                                      userDate.add(nameController.text.trim());
                                      userDate.add(emailController.text);
                                      userDate.add(passValue);
                                      userDate.add(confirmPassValue);

                                      if (nameController.text.isNotEmpty! &&
                                          emailController.text.isNotEmpty! &&
                                          passValue.isNotEmpty &&
                                          confirmPassValue.isNotEmpty) {
                                        BlocProvider.of<AuthCubit>(context)
                                            .register(
                                                nameController.text!.trim(),
                                                emailController.text!,
                                                passValue,
                                                confirmPassValue);
                                      }
                                    }
                                  },
                              child: state is AuthLoading?
                               Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Sign up', style: TextStyle(
                                      color: Colors.white , fontSize: 20.sp
                                  ),),
                                  SizedBox(width: 15.w,),
                                  SizedBox(
                                    height: 15.h,
                                    width: 15.w,
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ):  Text('Sign up', style: TextStyle(
                                  color: Colors.white , fontSize: 20.sp
                              ),)

                          ),
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(Strings.haveAnAcc,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16.sp,
                                    color: Colors.black)),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, AppRouters.loginStudentRoute,
                                arguments: false
                            );
                          },
                          child: Text(Strings.login,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16.sp,
                                      color: color.primaryColor)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }

  void SignUp() {
    if (formKey.currentState?.validate() == false) {
      return;
    }
  }
}
