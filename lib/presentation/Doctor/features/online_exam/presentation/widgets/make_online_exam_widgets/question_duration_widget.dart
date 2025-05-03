import 'package:duration_picker/duration_picker.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/bloc/online_exam_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionDurationWidget extends StatelessWidget {
  const QuestionDurationWidget({
    super.key,
    required this.questionDuration,
    required this.questionIndex,
  });

  final Duration? questionDuration;
  final int questionIndex;

  @override
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
            color: Colors.white, // White text
          ),
        ),
        SizedBox(width: 5.w), // Responsive spacing
        // Duration Picker Button
        IconButton(
          onPressed: () async {
            final resultingDuration = await showDurationPicker(
              context: context,
              initialTime: const Duration(minutes: 1),
              baseUnit: BaseUnit.second,
              upperBound: const Duration(minutes: 15),
              lowerBound: const Duration(minutes: 1),
            );
            if (!context.mounted) return;
            context.read<OnlineExamBloc>().add(
              UpdateQuestionDurationEvent(
                resultingDuration ?? questionDuration,
                questionIndex,
              ),
            );
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
                '${questionDuration!.inMinutes} min',
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