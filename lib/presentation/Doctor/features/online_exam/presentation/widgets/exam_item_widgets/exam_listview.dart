// import 'package:edu_platt/core/utils/Assets/appAssets.dart';
// import 'package:edu_platt/core/utils/customDialogs/custom_dialog.dart';
// import 'package:edu_platt/presentation/Doctor/features/course_details/cubit/dialog_cubit.dart';
// import 'package:edu_platt/presentation/Doctor/features/course_details_utils/dialog_helper_function.dart';
// import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/bloc/exam_bloc.dart';
// import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/exam_item_widgets/online_exam_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class ExamListView extends StatelessWidget {
//   const ExamListView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<DialogCubit, dynamic>(
//       listener: (context, state) {
//         if (state == StatusDialog.SUCCESS) {
//           Navigator.pop(context);
//           showSuccessDialog(context);
//         }
//         if (state == StatusDialog.LOADING) {
//           showLoadingDialog(context);
//         }
//         if (state == StatusDialog.FAILURE) {
//           Navigator.pop(context);
//           showErrorDialog(context);
//         }
//       },
//       child: BlocBuilder<ExamBloc, ExamState>(
//         builder: (context, state) {
//           if (state is ExamLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is ExamLoaded) {
//             return ListView.builder(
//               itemCount: state.exams.length,
//               itemBuilder: (context, index) {
//                 final exam = state.exams[index];
//
//                 ///TODO:: MAKE DISCARD CALLBACK FUNCTION
//                 return OnlineExamCard(
//                   onPressed: () async {
//                     bool? isConfirmed =
//                     await CustomDialogs.showConfirmationDialog(
//                         context: context,
//                         title: 'Alert',
//                         content:
//                         'Are you sure to delete ${exam.examTitle}',
//                         imageUrl: AppAssets.trashBin);
//                     if (isConfirmed != null && isConfirmed) {
//                       context.read<ExamBloc>().add(
//                           DeleteExam(exam.examId, exam.isExamFinished));
//                     }
//                   }, examEntity:exam,
//                 );
//               },
//             );
//           } else if (state is ExamError) {
//             return Center(child: Text(state.message));
//           }
//           return Container();
//         },
//       ),
//     );
//   }
// }
