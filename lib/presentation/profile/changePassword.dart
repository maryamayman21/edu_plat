
import 'package:edu_platt/core/utils/Assets/appAssets.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/core/utils/validations/password_validation.dart';
import 'package:edu_platt/presentation/sharedWidget/buttons/custom_button.dart';
import 'package:edu_platt/presentation/sharedWidget/password_visibility_cubit/confrim_password_visablity_cubit.dart';
import 'package:edu_platt/presentation/sharedWidget/password_visibility_cubit/password_matched_visability_cubit.dart';
import 'package:edu_platt/presentation/sharedWidget/password_visibility_cubit/password_visiability_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:password_strength_checker/password_strength_checker.dart';
import '../../core/localDB/secureStorage/secure_stoarge.dart';
import '../Routes/custom_AppRoutes.dart';
import '../forgetAndResetPassword/cubit/forget_pass_cubit.dart';
import '../forgetAndResetPassword/data/repository/repository.dart';
import '../forgetAndResetPassword/data/web_services/web_services.dart';
import '../sharedWidget/password_textfield.dart';


class Changepassword extends StatefulWidget {
  const Changepassword({super.key, required this.email});
  final String email;
  @override
  State<Changepassword> createState() => _SetpasswordState();
}

class _SetpasswordState extends State<Changepassword> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final passNotifier = ValueNotifier<PasswordStrength?>(null);
  //bool isPasswordVisible = false;
  var formKey = GlobalKey<FormState>();
  bool isPassObscure = true;
  bool isConfirmPassObscure = true;
  bool isCurrentPassObscure = true;
  String confirmPassValue = '';
  String currentPassValue = '';
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
                  ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Text(state.message)),
                  );
                  Navigator.pushReplacementNamed(
                    context,
                    AppRouters.changePasswordSuccRoute,
                  );
                } else if (state is ForgetPassFailure) {
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
                        BlocProvider(
  create: (context) => PasswordVisiabilityCubit(),
  child: BlocBuilder<PasswordVisiabilityCubit,PasswordVisiabilityState>(
                          builder: (context, state) {
                            bool isPasswordVisible = false;
                            IconData iconData = Icons.visibility_off;

                            if (state is PasswordVisibilityChanged) {
                              isPasswordVisible = state.visibility==
                                  PasswordVisibility.visible;
                              iconData = isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off;
                            }
                            return PasswordTextfield(
                              onChanged: (value) {
                                currentPassValue = value;
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
                              validator: (input) {
                                if (input!.trim().isEmpty || input == null) {
                                  return 'Password cannot be empty';
                                }
                                return null;
                              },
                              hintText: 'Current Password',
                              label: 'Current Password',
                              isObscure: isPasswordVisible,
                              keyboardType: TextInputType.text,
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
                         SizedBox(height: 8.h),
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
  create: (context) => ConfrimPasswordVisablityCubit (),
  child: BlocBuilder<ConfrimPasswordVisablityCubit ,ConfrimPasswordVisablityState>(
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
                                passNotifier.value =
                                    PasswordStrength.calculate(text: value);
                                passValue = value;
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
                              validator: isPasswordValid,
                              hintText: 'Enter Password',
                              label: 'Password',
                              isObscure:  isPasswordVisible,
                            );
                          },
                        ),
),
                        // SizedBox(height: 5.h),
                        SizedBox(height: 20.h),
                        PasswordStrengthChecker(
                          strength: passNotifier,
                          configuration:
                          const PasswordStrengthCheckerConfiguration(
                            borderColor: Colors.grey,

                          ),

                        ),

                        SizedBox(height: 20.0.h),
                        BlocProvider(
  create: (context) =>PasswordMatchedVisabilityCubit(),
  child: BlocBuilder<PasswordMatchedVisabilityCubit, PasswordMatchedVisabilityState>(
                          builder: (context, state) {
                            bool isPasswordVisible = false;
                            IconData iconData = Icons.visibility_off;
                            if (state is PasswordMatchedVisibilityChanged) {


                              isPasswordVisible = state.visibility ==
                                  PasswordMatchedVisibility.visible;
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
                                      .read<PasswordMatchedVisabilityCubit>()
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
                              isObscure:  isPasswordVisible,
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
                            builder: (context, state){
                              return Padding(
                                padding: EdgeInsets.only(top: 30.h, bottom: 10.h), // Responsive padding
                                child: SizedBox(
                                  width: double.infinity, // Make button full width
                                  child: CustomButtonWidget(
                                    onPressed: state is ForgetPassLoading
                                        ? null // Disable button when loading
                                        : () async {
                                      passValue = passValue.trim();
                                      confirmPassValue = confirmPassValue.trim();
                                      currentPassValue = currentPassValue.trim();

                                      if (passValue.isNotEmpty &&
                                          confirmPassValue.isNotEmpty &&
                                          currentPassValue.isNotEmpty) {
                                        debugPrint('current pass: $currentPassValue');
                                        debugPrint('pass value: $passValue');
                                        debugPrint('confirm pass value: $confirmPassValue');

                                        final token = await SecureStorageService.read('token');
                                        if (token != null) {
                                          BlocProvider.of<ForgetPassCubit>(context)
                                              .resetPassword(
                                              currentPassValue,
                                              passValue,
                                              confirmPassValue,
                                              token,
                                              widget.email
                                          );
                                        }
                                      }
                                    },
                                    child: state is ForgetPassLoading
                                        ? Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Change Password',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.sp, // Responsive font size
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(width: 15.w), // Responsive spacing
                                        SizedBox(
                                          height: 15.h, // Responsive height
                                          width: 15.w, // Responsive width
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2.w, // Responsive stroke width
                                          ),
                                        ),
                                      ],
                                    )
                                        : Text(
                                      'Change Password',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.sp, // Responsive font size
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
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

}
