// import 'package:edu_platt/core/utils/Color/color.dart';
// import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/bloc/exam_bloc.dart';
// import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/exam_item_widgets/exam_listview.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class ExamTab extends StatelessWidget {
//   const ExamTab({super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text('Recent Exams',
//             style: TextStyle(
//               fontSize: 22.sp, // Slightly smaller for better balance
//               fontWeight: FontWeight.bold,
//               color: color.primaryColor,
//             ),
//           ),
//           bottom: TabBar(
//             onTap: (index) {
//               final isTaken = !(index == 0);
//               context.read<ExamBloc>().add(
//                   FetchExamsEvent(isExamtaken: isTaken));
//             },
//             tabs: const [
//               Tab(text: 'Not Taken Exams'),
//               Tab(text: 'Taken Exams'),
//             ],
//           ),
//         ),
//         body: const TabBarView(
//           children: [
//             ExamListView(),
//             ExamListView(),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// //-> create online exam  -> success -> print as pdf
// // -> create offline exam  -> announcement
// //-> create PDF exam -> written
// // -> create PDF exam -> MCQ
// //-> view recent exams  -> isTaken -> view degrees -> print PDF, model answer,-> Print PDF
// // -> not Taken -> update (if it online), -> delete
//
