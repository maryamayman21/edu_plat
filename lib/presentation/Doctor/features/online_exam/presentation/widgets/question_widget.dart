// import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/question_model.dart';
// import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/bloc/online_exam_bloc.dart';
// import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/question_head_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class QuestionWidgetListView extends StatefulWidget {
//   const QuestionWidgetListView({
//     super.key,
//     required this.questions,
//   });
//   final List<QuestionModel> questions;
//
//   @override
//   State<QuestionWidgetListView> createState() => _QuestionWidgetState();
// }
//
// class _QuestionWidgetState extends State<QuestionWidgetListView> {
//   final Map<int, List<String>> _optionTexts = {};
//
//   bool isEnabled = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: ListView.builder(
//         itemCount: widget.questions.length,
//         itemBuilder: (context, qIndex) {
//           // Ensure text values exist for each question
//           _optionTexts.putIfAbsent(
//             qIndex,
//             () => List.generate(
//               widget.questions[qIndex].options.length,
//               (oIndex) => widget.questions[qIndex].options[oIndex].text,
//             ),
//           );
//
//           return Card(
//             elevation: 5,
//             margin: const EdgeInsets.all(8.0),
//            // surfaceTintColor: Theme.of(context).primaryColor,
//             color:  Theme.of(context).primaryColor,
//             child: Column(
//               children: [
//                 ListTile(
//                   title: Text(
//                     widget.questions[qIndex].question.isNotEmpty
//                         ? widget.questions[qIndex].question
//                         : 'New Question',
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 22,
//                       fontWeight: FontWeight.w700
//                     ),
//                   ),
//
//                   trailing: IconButton(
//                       icon: const Icon(Icons.close, color: Colors.white),
//                       onPressed: () {
//                         context
//                             .read<OnlineExamBloc>()
//                             .add(RemoveQuestionEvent(qIndex));
//                         _optionTexts.remove(qIndex);
//                         print(_optionTexts);
//                       }),
//                 ),
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: widget.questions[qIndex].options.length,
//                   itemBuilder: (context, oIndex) {
//                     return Dismissible(
//                       key: UniqueKey(), // Ensures each item has a unique key
//                       direction: DismissDirection.endToStart, // Swipes from right to left
//                       background: Container(
//                         color: Colors.red,
//                         alignment: Alignment.centerRight,
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         child: const Icon(Icons.delete, color: Colors.white),
//                       ),
//                       onDismissed: (direction) {
//                         context.read<OnlineExamBloc>().add(RemoveOptionEvent(qIndex, oIndex));
//                         _optionTexts[qIndex]!.removeAt(oIndex);
//                         setState(() {});
//                       },
//                       child: ListTile(
//                         title: TextField(
//                           style: TextStyle(
//                             color: Theme.of(context).primaryColor,
//                              fontSize: 18
//                           ),
//                           controller: TextEditingController.fromValue(
//                             TextEditingValue(text: _optionTexts[qIndex]![oIndex]),
//                           ),
//
//                           decoration: InputDecoration(
//
//                               border: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.grey.shade200,
//                                 ),
//                                 borderRadius: BorderRadius.circular(30.0),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.grey.shade200,
//                                 ),
//                                 borderRadius: BorderRadius.circular(30.0),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color:Colors.grey.shade200,
//                                 ),
//                                 borderRadius: BorderRadius.circular(30.0),
//                               ),
//                            filled: true,
//                             fillColor: Colors.white
//                           ),
//                           onSubmitted: (newValue) {
//                             _optionTexts[qIndex]![oIndex] = newValue;
//                             context.read<OnlineExamBloc>().add(UpdateOptionEvent(qIndex, oIndex, newValue));
//                           },
//                         ),
//                         trailing: Checkbox(
//                           side: const BorderSide(
//                             color: Colors.white
//                           ),
//                           checkColor: Colors.white,
//                           splashRadius: 20,
//                           activeColor: Colors.green,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           value: widget.questions[qIndex].options[oIndex].isCorrectAnswer,
//                           onChanged: (bool? value) {
//                             context.read<OnlineExamBloc>().add(SelectCorrectAnswerEvent(qIndex, oIndex));
//                           },
//                         ),
//                       ),
//                     );
//
//                   },
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.add_circle_outline, color: Colors.white , size: 24,),
//                   onPressed: () {
//                     context.read<OnlineExamBloc>().add(AddOptionEvent(qIndex));
//                     _optionTexts[qIndex]!.add('');
//                     setState(() {});
//                   },
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
