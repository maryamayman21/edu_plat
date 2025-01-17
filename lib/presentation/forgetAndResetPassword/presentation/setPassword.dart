
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:password_strength_checker/password_strength_checker.dart';

import '../../../core/utils/Assets/appAssets.dart';
import '../../../core/utils/validations/password_validation.dart';
import '../../Auth/cubit/auth_cubit.dart';
import '../../Routes/custom_AppRoutes.dart';
import '../../sharedWidget/confrim_password_visablity_cubit.dart';
import '../../sharedWidget/custom_button.dart';
import '../../sharedWidget/password_textfield.dart';
import '../../sharedWidget/password_visiability_cubit.dart';
import '../cubit/forget_pass_cubit.dart';
import '../data/repository/repository.dart';
import '../data/web_services/web_services.dart';

class Setpassword extends StatefulWidget {
  const Setpassword({super.key});

  @override
  State<Setpassword> createState() => _SetpasswordState();
}

class _SetpasswordState extends State<Setpassword> {
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final passNotifier = ValueNotifier<PasswordStrength?>(null);

  var formKey = GlobalKey<FormState>();
  bool isPassObscure = true;
  bool isConfirmPassObscure = true;
  String confirmPassValue = '';
  String passValue = '';
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
          ),
          body: BlocProvider(
            create: (context) =>
                ForgetPassCubit(ForgetPassRepository(ForgetPassWebService())),
            child: BlocListener<ForgetPassCubit, ForgetPassState>(
              listener: (context, state) {
                if (state is ForgetPassSuccess) {
                  // print('Message: ${state.message}');
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('Password changed successfully')),
                  // );
                  Navigator.pushReplacementNamed(
                    context,
                    AppRouters.passwordResetSuccess,
                  );
                } else if (state is ForgetPassFailure) {
                  print('Error: ${state.error}');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }
              },
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 64.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Set new password',
                          style: Theme.of(context)
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
                            'Create new password. Ensure it differs from previous one for security.',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: 20.0.h,
                        ),
                        Text(
                          'Password',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: color.primaryColor,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 15.0.h,
                        ),
                        BlocProvider(
  create: (context) =>PasswordVisiabilityCubit(),
  child: BlocBuilder<PasswordVisiabilityCubit, PasswordVisiabilityState>(
                          builder: (context, state) {
                            bool isPasswordVisible = false;
                            IconData iconData = Icons.visibility_off;
                            if (state is PasswordVisibilityChanged) {
                              isPasswordVisible = state.visibility ==
                                  PasswordVisibility.visible;
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
                              isObscure: isPasswordVisible,
                            );
                          },
                        ),
),
                        // SizedBox(height: 5.h),
                        const SizedBox(height: 20),
                        PasswordStrengthChecker(
                          strength: passNotifier,
                          configuration:
                              const PasswordStrengthCheckerConfiguration(
                            borderColor: Colors.grey,
                          ),
                        ),

                        SizedBox(height: 20.0.h),
                        BlocProvider(
  create: (context) => ConfrimPasswordVisablityCubit(),
  child: BlocBuilder<ConfrimPasswordVisablityCubit, ConfrimPasswordVisablityState>(
                          builder: (context, state) {
                            bool isPasswordVisible = false;
                            IconData iconData = Icons.visibility_off;

                            if (state is ConfirmPasswordVisibilityChanged) {
                              isPasswordVisible = state.visibility ==
                                  ConfirmPasswordVisibility.visible;
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
                              isObscure: isPasswordVisible,
                              keyboardType: TextInputType.text,
                            );
                          },
                        ),
),
                        SizedBox(height: 5.0.h),
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
                            width: 10.0.w,
                          ),
                          passValue == confirmPassValue &&
                                  passValue.isNotEmpty &&
                                  confirmPassValue.isNotEmpty
                              ? const Icon(Icons.check_circle,
                                  color: Color(0xFF0B6C0E))
                              : const SizedBox()
                        ]),
                        SizedBox(
                          height: 30.0.h,
                        ),
                        BlocBuilder<ForgetPassCubit, ForgetPassState>(
                            builder: (context, state) {
                              return Padding(
                                padding: REdgeInsets.only(
                                    top: 30, bottom: 10),
                                child: CustomButtonWidget(
                                    onPressed: state is ForgetPassLoading
                                        ? () {}
                                        : () {
                                      passValue.trim();
                                      confirmPassValue.trim();
                                      if (passValue != null && confirmPassValue !=  null) {
                                        print('pass value : $passValue');
                                        print('confirm pass value : $confirmPassValue');
                                        BlocProvider.of<ForgetPassCubit>(context)
                                            .changePassword(passValue , confirmPassValue);
                                      }
                                    },
                                    child: state is ForgetPassLoading
                                        ? const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Change Password',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 20),
                                        ),
                                        SizedBox(width: 15,),
                                        SizedBox(
                                          height: 15,
                                          width: 15,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    )
                                        : const Text(
                                      'Change Password',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )),
                              );
                            }
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }

  void updatePassword() {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    Navigator.pushReplacementNamed(context, AppRouters.passwordResetSuccess);
  }
}
