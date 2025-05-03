
import 'package:duration_picker/duration_picker.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/bloc/offline_exam_bloc.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/bloc/online_exam_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OfflineQuestionDuration extends StatelessWidget {
  const OfflineQuestionDuration({super.key, required this.duration,  });
  final Duration duration;
 // final Function(Duration) onDurationChanged;

  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Duration Label
        Text(
          'Duration',
          style: TextStyle(
            fontSize: 18.sp, // Responsive font size
            fontWeight: FontWeight.w600,
            color: Colors.blue, // White text
          ),
        ),
        SizedBox(width: 5.w), // Responsive spacing
        // Duration Picker Button
        IconButton(
          onPressed: () async {
            final resultingDuration = await showDurationPicker(
              context: context,
              initialTime: const Duration(minutes: 30),
              baseUnit: BaseUnit.second,
              upperBound: const Duration(hours: 2),
              lowerBound: const Duration(minutes: 30),
            );
            if (!context.mounted) return;
            context.read<OfflineExamBloc>().add(
                SetDurationEvent(resultingDuration ?? duration));
          },
          icon: Container(
            width: 80.w, // Responsive width
            height: 40.h, // Responsive height
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r), // Responsive border radius
            ),
            child: Center(
              child: Text(
                '${duration!.inMinutes} min',
                style: TextStyle(
                  fontSize: 18.sp, // Responsive font size
                  fontWeight: FontWeight.w600,
                  color: Colors.blue, // Blue text
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
