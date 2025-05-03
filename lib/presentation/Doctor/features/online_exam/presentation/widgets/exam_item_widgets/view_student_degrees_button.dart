// import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class ViewStudentDegreesButton extends StatelessWidget {
//   const ViewStudentDegreesButton({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.center,
//       child: ElevatedButton(
//         onPressed: () {
//           Navigator.pushNamed(context, AppRouters.ExamScreen);
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.green,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8.r), // Responsive border radius
//           ),
//           padding: EdgeInsets.symmetric(
//             horizontal: 20.w, // Responsive horizontal padding
//             vertical: 12.h, // Responsive vertical padding
//           ),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               'View Students Degrees',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 16.sp, // Responsive font size
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(width: 8.w), // Responsive spacing between text and icon
//             Icon(
//               Icons.arrow_forward_ios,
//               color: Colors.white,
//               size: 16.sp, // Responsive icon size
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }