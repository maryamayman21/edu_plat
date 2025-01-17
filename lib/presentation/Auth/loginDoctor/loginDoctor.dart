// import 'package:edu_plat/core/utils/Assets/appAssets.dart';
// import 'package:edu_plat/presentation/sharedWidget/password_textfield.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../core/utils/Strings/string.dart';
// import '../../../core/utils/validations/email_validation.dart';
// import '../../../core/utils/validations/password_validation.dart';
// import '../../Routes/appRouts.dart';
// import '../../Routes/custom_AppRoutes.dart';
// import '../../sharedWidget/custom_button.dart';
// import '../../sharedWidget/custom_textfield.dart';
//
// class LoginScreenDoctor extends StatefulWidget {
//   const LoginScreenDoctor({super.key});
//
//   @override
//   State<LoginScreenDoctor> createState() => _LoginScreenDoctorState();
// }
//
// class _LoginScreenDoctorState extends State<LoginScreenDoctor> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   bool isObscure = true;
//   var formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         scrolledUnderElevation: 0,
//         // leading: IconButton(
//         //     onPressed: () {
//         //       Navigator.pushReplacementNamed(
//         //           context, AppRouter.studentOrDoctor);
//         //     },
//         //     icon: const Icon(Icons.arrow_back)),
//       ),
//       body: SingleChildScrollView(
//         child: Form(
//           key: formKey,
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 90.h),
//             child: Column(
//               // mainAxisAlignment: MainAxisAlignment.space,
//               children: [
//                 Image.asset(
//                   AppAssets.logo,
//                   height: 90.h,
//                 ),
//                 Padding(
//                   padding: REdgeInsets.all(5.0),
//                   child: Text(Strings.appDescription,
//                       style: Theme.of(context).textTheme.titleMedium),
//                 ),
//                 Text(
//                   Strings.welcomeback,
//                   style: Theme.of(context)
//                       .textTheme
//                       .titleMedium!
//                       .copyWith(fontSize: 22.sp, fontWeight: FontWeight.w500),
//                 ),
//                 SizedBox(
//                   height: 80.h,
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     Strings.login,
//                     style: Theme.of(context)
//                         .textTheme
//                         .titleMedium!
//                         .copyWith(fontSize: 32.sp, fontWeight: FontWeight.w700),
//                   ),
//                 ),
//                 CustomTextfield(
//                     controller: emailController,
//                     label: 'Email',
//                     keyboardType: TextInputType.emailAddress,
//                     hintText: 'Enter your Email',
//                     validator: isEmailValide),
//                 SizedBox(
//                   height: 5.h,
//                 ),
//                 PasswordTextfield(
//                   validator: isPasswordValid,
//                   hintText: 'Enter Password',
//                   label: 'Password',
//                   isObscure: isObscure,
//                   onToggle: () {
//                     setState(
//                       () {
//                         isObscure = !isObscure;
//                       },
//                     );
//                   },
//                 ),
//                 Padding(
//                   padding: REdgeInsets.symmetric(vertical: 30),
//                   child: CustomButtonWidget(
//                     text: Strings.login,
//                     onPressed: () {
//                       Login();
//                       Navigator.pushReplacementNamed(context, AppRouters.doctorHomeRoute);
//                     },
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pushNamed(
//                         context, AppRouters.setPassword);
//                   },
//                   child: Padding(
//                     padding: REdgeInsets.all(8.0),
//                     child: Text(Strings.ResetPassword,
//                         style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                               fontWeight: FontWeight.w800,
//                               fontSize: 16.sp,
//                             )),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void Login() {
//     if (formKey.currentState?.validate() == false) {
//       return;
//     }
//
//
//   }
// }
