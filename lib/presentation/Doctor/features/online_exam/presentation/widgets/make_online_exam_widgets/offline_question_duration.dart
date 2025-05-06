import 'package:duration_picker/duration_picker.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/bloc/offline_exam_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OfflineQuestionDuration extends StatelessWidget {
  const OfflineQuestionDuration({super.key, required this.duration});
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Label
          Text(
            'Exam Duration',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          // Duration Button
          InkWell(
            onTap: () async {
              final resultingDuration = await showDurationPicker(
                context: context,
                initialTime: duration,
                baseUnit: BaseUnit.minute,
                upperBound: const Duration(hours: 3),
                lowerBound: const Duration(minutes: 10),
              );
              if (!context.mounted) return;
              context.read<OfflineExamBloc>().add(
                SetDurationEvent(resultingDuration ?? duration),
              );
            },
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.2),
                    blurRadius: 6.r,
                    offset: Offset(2.w, 4.h),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.timer,
                    color: Colors.blueAccent,
                    size: 22.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    '${duration.inMinutes} min',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
