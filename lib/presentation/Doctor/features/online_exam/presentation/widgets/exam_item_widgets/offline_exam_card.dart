import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/domain/entity/exam_entity.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/exam_item_widgets/view_student_degrees_button.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:edu_platt/presentation/sharedWidget/buttons/action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OfflineExamCard extends StatelessWidget {
  const OfflineExamCard({
    super.key,
    required this.onPressed,
    required this.examEntity,
  });

  final ExamEntity examEntity;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      examEntity.examTitle,
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: color.primaryColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.wifi_off,
                          color: Colors.white,
                          size: 14.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Offline',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),

              // Date
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: Colors.grey,
                    size: 16.sp,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      "Date: ${examEntity.date}",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.sp,
                        fontStyle: FontStyle.italic,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Duration and Questions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.timer,
                        color: Colors.deepOrangeAccent,
                        size: 16.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "Duration: ${examEntity.duration} min",
                        style: TextStyle(
                          color: color.primaryColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     Icon(
                  //       Icons.quiz,
                  //       color: Colors.yellow,
                  //       size: 16.sp,
                  //     ),
                  //     SizedBox(width: 8.w),
                  //     Text(
                  //       'Questions: ${examEntity.questionNumbers}',
                  //       style: TextStyle(
                  //         color: color.primaryColor,
                  //         fontSize: 16.sp,
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
              SizedBox(height: 12.h),

              // Grading
              Row(
                children: [
                  Icon(
                    Icons.grade,
                    color: Colors.purple,
                    size: 16.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    "Grading: ${examEntity.totalMark} marks",
                    style: TextStyle(
                      color: color.primaryColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),

              // Location
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.green,
                    size: 16.sp,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      "Location: ${examEntity.location}",
                      style: TextStyle(
                        color: color.primaryColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // Buttons
              if (!examEntity.isExamFinished)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ActionButton(
                      text: 'Edit',
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRouters.doctorOfflineExamEditScreen,
                          arguments: examEntity.examId,
                        );
                      },
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      iconData: Icons.edit,
                    ),
                    ActionButton(
                      text: 'Discard',
                      onPressed: onPressed,
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      iconData: Icons.remove,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
