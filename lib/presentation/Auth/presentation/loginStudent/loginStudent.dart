import 'package:edu_platt/core/utils/Assets/appAssets.dart';
import 'package:edu_platt/presentation/sharedWidget/password_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/localDB/secureStorage/secure_stoarge.dart';
import '../../../../core/utils/Color/color.dart';
import '../../../../core/utils/Strings/string.dart';
import '../../../../core/utils/validations/email_validation.dart';
import '../../../../core/utils/validations/password_validation.dart';
import '../../../Routes/custom_AppRoutes.dart';
import '../../../sharedWidget/custom_button.dart';
import '../../../sharedWidget/custom_textfield.dart';
import '../../cubit/auth_cubit.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/web_services/auth_web_service.dart';

class LoginScreenStudent extends StatefulWidget {
  const LoginScreenStudent({super.key, this.isDoctor = false});
  final bool isDoctor;
  @override
  State<LoginScreenStudent> createState() => _LoginScreenStudentState();
}

class _LoginScreenStudentState extends State<LoginScreenStudent> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObscure = true;
  String passValue = "";
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: BlocProvider(
        create: (context) => AuthCubit(AuthRepository(AuthWebService())),
  child: BlocListener<AuthCubit, AuthState>(
  listener: (context, state) async{
    if (state is AuthSuccess) {
    print('Message: ${state.message}');
    ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Login successful!')),
    );

    // Retrieve the role from SharedPreferences
   // final prefs = await SharedPreferences.getInstance();
    final role = await SecureStorageService.read('role');

    if (role == 'Student') {
      Navigator.pushNamedAndRemoveUntil(context, AppRouters.HomeStudent, (route) => false);
   // Navigator.pushReplacementNamed(context , AppRouters.HomeStudent);
    } else  {
      Navigator.pushNamedAndRemoveUntil(context, AppRouters.doctorHomeRoute, (route) => false);

    }}
    else if (state is AuthFailure) {
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
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 90.h),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.space,
              children: [
                Image.asset(
                  AppAssets.logo,
                  height: 90.h,
                ),
                Padding(
                  padding: REdgeInsets.all(3.0),
                  child: Text(Strings.appDescription,
                      style: Theme.of(context).textTheme.titleMedium),
                ),
                Text(
                  Strings.welcomeback,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 22.sp, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 80.h,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Strings.login,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 32.sp, fontWeight: FontWeight.w700),
                  ),
                ),
                CustomTextfield(
                    controller: emailController,
                    label: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Enter your Email',
                    validator: isEmailValide),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    bool isPasswordVisible = false;
                    IconData iconData = Icons.visibility_off;

                    if (state is AuthPasswordVisibilityChanged) {
                      isPasswordVisible =
                          state.visibility == AuthPasswordVisibility.visible;
                      iconData = isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off;
                    }
                 return PasswordTextfield(
                  validator: isPasswordValid,
                   onChanged: (value){
                      passValue = value;
                   },
                  hintText: 'Enter Password',
                  label: 'Password',
                  isObscure: !isPasswordVisible,
                 suffixIcon: IconButton(
                 onPressed: () {
                  context
                 .read<AuthCubit>()
                .togglePasswordVisibility();
                 },
               icon: Icon(iconData),
      ),
                 
                  
                );
  },
),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return Padding(
                      padding: REdgeInsets.only(top: 30, bottom: 10),
                      child: CustomButtonWidget(
                        onPressed: state is AuthLoading
                            ? (){}
                            : () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            print(emailController.text!);
                            print(passValue);
                            BlocProvider.of<AuthCubit>(context).login(emailController.text!, passValue);
                          }
                        },
                        child: state is AuthLoading?
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Login', style: TextStyle(
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
                        ): const Text('Login', style: TextStyle(
                          color: Colors.white , fontSize: 20
                      ),)
                      ),
                    );
                  },
                ),
                widget.isDoctor
                    ? TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AppRouters.forgetPassword);
                        },
                        child: Text(Strings.ResetPassword,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16.sp,
                                    )),
                      )
                    : TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, AppRouters.forgetPassword);
                        },
                        child: Text(Strings.forgetPassword,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16.sp,
                                    )),
                      ),
                widget.isDoctor
                    ? const SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(Strings.dontHaveAnAcc,
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
                                  context, AppRouters.registerRoute);
                            },
                            child: Text(Strings.signUp,
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
    );
  }

  void Login() {
    if (formKey.currentState?.validate() == false) {
      return;
    }
  }
}
