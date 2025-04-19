//
// import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/bloc/online_exam_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// class TimePickerWidget extends StatelessWidget {
//   const TimePickerWidget({super.key, required this.examDuration});
//   final DateTime? examDuration;
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: const Text("Duration"),
//       subtitle: Text(
//        examDuration != null
//             ? "${examDuration!.hour}h ${examDuration!.minute}m"
//             : "Select Duration",
//       ),
//       trailing: const Icon(Icons.access_time, color: Colors.blue),
//       onTap: () => TimePickerHelper.pickDuration(context),
//     );
//
//   }
// }
//
//
// class TimePickerHelper {
//   static Future<void> pickDuration(BuildContext context) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: const TimeOfDay(hour: 1, minute: 0),
//     );
//
//     if (picked != null) {
//       final DateTime duration = DateTime(0, 0, 0, picked.hour, picked.minute);
//       context.read<OnlineExamBloc>().add(SetExamDateEvent(duration));
//     }
//   }
// }
