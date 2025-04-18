// import 'package:edu_platt/presentation/Student/screen/exam/startExam/StartExam.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../../../core/utils/Color/color.dart';
// import 'tab_widget.dart';
//
// class CourseTabs extends StatelessWidget {
//   const CourseTabs({
//     super.key,
//     required this.onTabSelected,
//     required this.selectedIndex,
//     required this.courseCategories,
//   });
//
//   final ValueChanged<int> onTabSelected; // Callback to notify the parent
//   final int selectedIndex; // Currently selected tab index
//   final List<String> courseCategories; // Categories for tabs
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: List.generate(courseCategories.length, (index) {
//         return CourseTab(
//           text: courseCategories[index],
//           backgroundColor:
//           selectedIndex == index ? color.primaryColor : Colors.white,
//           foregroundColor:
//           selectedIndex == index ? Colors.white : color.primaryColor,
//             onPressed: () {
//               onTabSelected(index); // Notify parent on tab click
//             });
//       }),
//     );
//   }
// }
