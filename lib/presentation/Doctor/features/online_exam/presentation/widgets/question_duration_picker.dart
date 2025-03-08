import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionDurationPicker extends StatelessWidget {
  final Duration duration;
  final Function(Duration) onDurationChanged;

  const QuestionDurationPicker({super.key, required this.duration, required this.onDurationChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Question Duration',
          style: TextStyle(
            fontSize: 18.sp, // Responsive font size
            fontWeight: FontWeight.w600,
            color: Colors.blue,
          ),
        ),
        DurationPicker(
          duration: duration,
          baseUnit: BaseUnit.second,
          onChange: onDurationChanged,
          upperBound: const Duration(minutes: 15),
          lowerBound: const Duration(minutes: 1),
        ),
      ],
    );
  }
}