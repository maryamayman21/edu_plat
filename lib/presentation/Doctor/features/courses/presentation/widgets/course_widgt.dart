// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../../../core/utils/Color/color.dart';
//
// class CourseWidgt extends StatelessWidget {
//   const CourseWidgt({
//     super.key,
//
//     required this.courseDescription,
//     required this.courseCode,
//     required this.creditHours,
//      this.onTap, this.onDelete,
//   });
//   final String courseDescription;
//   final String courseCode;
//   final String creditHours;
//   final void Function()? onTap;
//   final void Function()? onDelete;
//
//   @override
//   Widget build(BuildContext context) {
//     return
//        InkWell(
//         onTap: onTap,
//         child: Container(
//             width: double.infinity,
//             height: 80,
//             margin: const EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.2), // Shadow color
//                   spreadRadius: 5.0, // Spread radius
//                   blurRadius: 3.0, // Blur radius
//                   offset: const Offset(
//                       1, 6), // Shadow position (horizontal, vertical)
//                 ),
//               ],
//               borderRadius: BorderRadius.all(Radius.circular(30.r)),
//             ),
//             child: Stack(
//               children: [
//                 Container(
//                   width: 135,
//                   decoration:  BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         color.onPrimaryColor, // Start with the container's color
//                         color.onPrimaryColor.withOpacity(1), // Lighter shade
//                         color.onPrimaryColor.withOpacity(0.6), // Transparent shadow
//                       ],
//                       begin: Alignment.centerLeft,
//                       end: Alignment.centerRight,
//                     ),
//
//                     color:  color.onPrimaryColor,
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(30.r),
//                         bottomLeft: Radius.circular(30.r)),
//                   ),
//                   child: Center(
//                     child: Text(courseCode,
//                         style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                             letterSpacing: 2,
//                             shadows: [
//                               const Shadow(
//                                 offset: Offset(2.0, 2.0),
//                                 blurRadius: 4.0,
//                                 color: Colors.black,
//                               ),
//                             ],
//                             color: Colors.white,
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold)),
//                   ),
//                 ),
//                 Positioned(
//                   top: 25,
//                   left: 140,
//                   child: Text(courseDescription,
//
//                       style: Theme.of(context).textTheme.titleSmall!.copyWith(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w800)),
//                 ),
//                 Positioned(
//                   right: 10,
//                   bottom: 10,
//                   child: Text(
//                     creditHours,
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyLarge!
//                         .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
//                   ),
//                 ),
//
//                 Positioned(
//                    right: 1,
//                    top: 1,
//                   child:
//                    IconButton(onPressed: onDelete, icon: const Icon(Icons.delete,
//                    size: 22,
//                    )),
//                 )
//               ],
//             )),
//     );
//   }
// }
//
// // return InkWell(
// // onTap: onTap,
// // child: Container(
// // width: double.infinity,
// // height: 120,
// // margin: EdgeInsets.only(bottom: 16),
// // decoration: BoxDecoration(
// // color: Colors.white,
// // boxShadow: [
// // BoxShadow(
// // color: Colors.black.withOpacity(0.2), // Shadow color
// // spreadRadius: 1.0, // Spread radius
// // blurRadius: 2.0, // Blur radius
// // offset: const Offset(1, 2), // Shadow position (horizontal, vertical)
// // ),
// // ],
// // borderRadius: BorderRadius.all(Radius.circular(15.r)),
// //
// // ),
// // child: Stack(
// // children: [
// // Container(
// //
// // width: 120,
// // decoration: BoxDecoration(
// //
// // color: color.primaryColor,
// // borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15) ),
// //
// // ),
// // child: Center(
// // child: Text(courseCode, style:
// //
// // Theme.of(context).textTheme.bodySmall!.copyWith(
// // color: Colors.white,
// // fontSize: 20,
// // fontWeight: FontWeight.w700
// // )
// // ),
// // ),
// // ),
// //
// // Positioned(
// // top: 32,
// // left: 140,
// // child: Text(courseDescription,
// // //  maxLines: 1,
// // style:
// //
// // Theme.of(context).textTheme.titleSmall!.copyWith(
// // fontSize: 16,
// // // overflow: TextOverflow.ellipsis,
// // fontWeight: FontWeight.w600
// // )
// // ),
// // ),
// // Positioned(
// // right: 10,
// // bottom: 10,
// // child: Text(creditHours, style:
// //
// // Theme.of(context).textTheme.bodyLarge!.copyWith(
// // fontSize: 14,
// // fontWeight: FontWeight.w400
// //
// // ),
// // ),
// // ),
// // ],
// // )
// // ),
// //
// //);
