import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/domain/entity/exam_entity.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:edu_platt/presentation/sharedWidget/buttons/action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnlineExamCard extends StatelessWidget {
  const OnlineExamCard({
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
                  Flexible(
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.wifi, color: Colors.white, size: 14.sp),
                        SizedBox(width: 4.w),
                        Text(
                          'Online',
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
                  Icon(Icons.calendar_today, color: Colors.grey, size: 16.sp),
                  SizedBox(width: 8.w),
                  Text(
                    "Date: ${examEntity.date}",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.sp,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Icon(Icons.code, color: Colors.green, size: 16.sp),
                  SizedBox(width: 8.w),
                  Text(
                    "Course code: ${examEntity.courseCode}",
                    style: TextStyle(
                      color: color.primaryColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),




              SizedBox(height: 16.h),

              // Duration & Questions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.timer, color: Colors.deepOrangeAccent, size: 16.sp),
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



                  Row(
                    children: [
                      Icon(Icons.quiz, color: Colors.yellowAccent, size: 16.sp),
                      SizedBox(width: 8.w),
                      Text(
                        'Questions: ${examEntity.questionNumbers}',
                        style: TextStyle(
                          color: color.primaryColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12.h),

              // Grading
              Row(
                children: [
                  Icon(Icons.grade, color: Colors.deepPurple, size: 16.sp),
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
              SizedBox(height: 20.h),

              // Action buttons
              examEntity.isExamFinished
                  ? Align(
                alignment: Alignment.center,
                child: ActionButton(
                  text: 'View Students Degrees',
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRouters.doctorStudentDegreesScreen,
                      arguments: examEntity.examId,
                    );
                  },
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  iconData: Icons.arrow_forward_ios,
                ),
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ActionButton(
                    text: 'Edit',
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRouters.doctorOnlineExamEditScreen,
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
