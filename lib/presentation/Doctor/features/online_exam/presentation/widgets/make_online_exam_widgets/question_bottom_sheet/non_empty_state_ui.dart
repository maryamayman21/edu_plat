// import 'package:edu_platt/core/utils/Assets/appAssets.dart';
// import 'package:edu_platt/core/utils/Color/color.dart';
// import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/bloc/online_exam_bloc.dart';
// import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/counter_listview.dart';
// import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/course_code_field.dart';
// import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/course_title_field.dart';
// import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_bottom_sheet/add_question_widget.dart';
// import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_bottom_sheet/date_picker_widget.dart';
// import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_wigdet_listView.dart';
// import 'package:edu_platt/presentation/sharedWidget/buttons/custom_elevated_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class NonEmptyStateUi extends StatefulWidget {
//   const NonEmptyStateUi({super.key});
//
//   @override
//   State<NonEmptyStateUi> createState() => _NonEmptyStateUiState();
// }
//
// class _NonEmptyStateUiState extends State<NonEmptyStateUi> {
//   DateTime selectedDate = DateTime.now();
//   String _courseCode = '';
//   String _courseTitle = '';
//   DateTime? _examDate = null;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Form(
//           key: _formKey,
//           child: CustomScrollView(
//             slivers: [
//               SliverAppBar(
//                 expandedHeight: 240,
//                 centerTitle: true,
//                 title:  Text('Make Online Exam',
//                   style: TextStyle(
//                     fontSize: 22.sp, // Slightly smaller for better balance
//                     fontWeight: FontWeight.bold,
//                     color: color.primaryColor,
//                   ),
//                 ),
//                 flexibleSpace: FlexibleSpaceBar(
//                   background: Column(
//                     children: [
//                       const SizedBox(height: 50),
//                       CourseTitleField(
//                         onChanged: (value) {
//                           _courseTitle = value;
//                         },
//                         courseTitle: _courseTitle,
//                       ),
//                       CourseCodeField(
//                         onChanged: (value) {
//                           _courseCode = value;
//                         },
//                         courseCode: _courseCode,
//                       ),
//                       MyDatePicker(
//                         date: _examDate,
//                         onChanged: (value) {
//                           _examDate = value;
//                           context
//                               .read<OnlineExamBloc>()
//                               .add(SetExamDateEvent(selectedDate));
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               context.read<OnlineExamBloc>().state.exam.question.isNotEmpty ?
//               SliverPersistentHeader(
//                 pinned: true,
//                 delegate: _CounterListHeaderDelegate(
//                   child: SizedBox(
//                     height: 70,
//                     child: CounterListview(
//                       noOfQuestion: context
//                           .read<OnlineExamBloc>()
//                           .state
//                           .exam
//                           .noOfQuestions,
//                       totalDegree:
//                           context.read<OnlineExamBloc>().state.exam.totalMark,
//                       duration: context
//                           .read<OnlineExamBloc>()
//                           .state
//                           .exam
//                           .examDuration,
//                     ),
//                   ),
//                 ),
//               ) : const SliverToBoxAdapter(child: SizedBox.shrink()),
//               const SliverToBoxAdapter(
//                 child: SizedBox(height: 30),
//               ),
//
//               context.read<OnlineExamBloc>().state.exam.question.isNotEmpty ?
//               QuestionWidgetListView2(
//                 questions: context.read<OnlineExamBloc>().state.exam.question,
//               ) :
//               SliverToBoxAdapter(child: Image.asset(AppAssets.nnoNotesFound)),
//
//               const SliverToBoxAdapter(
//                 child: SizedBox(height: 50),
//               ),
//             ],
//           ),
//         ),
//         Positioned(
//           left: 0,
//           right: 0,
//           bottom: 0,
//           child: Container(
//             color: Colors.white,
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 CustomElevatedButton(
//                   onPressed: () => _showQuestionBottomSheet(context),
//                   text: '+ New Question',
//                 ),
//                 context.read<OnlineExamBloc>().state.exam.question.isNotEmpty ?
//
//                 CustomElevatedButton(
//                   onPressed: () {
//                     if (!_formKey.currentState!.validate()) return;
//                     context
//                         .read<OnlineExamBloc>()
//                         .add(SetExamCourseTitleEvent(_courseTitle));
//                     context
//                         .read<OnlineExamBloc>()
//                         .add(SetExamCourseCodeEvent(_courseCode));
//                     context.read<OnlineExamBloc>().add(const CreateExamEvent());
//                   },
//                   text: 'Create Online Exam',
//                 ) : const SizedBox.shrink()
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// void _showQuestionBottomSheet(BuildContext context) {
//   final onlineExamBloc = context.read<OnlineExamBloc>();
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//     ),
//     builder: (modalContext) {
//       return Padding(
//         padding:
//             EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//         child: SingleChildScrollView(
//           child: AddQuestionWidget(onlineExamBloc: onlineExamBloc),
//         ),
//       );
//     },
//   );
// }
//
// class _CounterListHeaderDelegate extends SliverPersistentHeaderDelegate {
//   final Widget child;
//
//   _CounterListHeaderDelegate({required this.child});
//
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Colors.transparent,
//         borderRadius: BorderRadius.all(Radius.circular(15)),
//       ),
//       child: child,
//     );
//   }
//
//   @override
//   double get maxExtent => 70;
//
//   @override
//   double get minExtent => 70;
//
//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
//     return true;
//   }
// }
