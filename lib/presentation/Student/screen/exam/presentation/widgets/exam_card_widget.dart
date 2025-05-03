import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Student/screen/exam/domain/entity/exam_card_entity.dart';
import 'package:edu_platt/presentation/sharedWidget/buttons/action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamCard extends StatelessWidget {
  const ExamCard(
      {super.key,
      required this.onPressed, required this.studentExam,
    });
  final StudentExamCardEntity studentExam;
 final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and Online/Offline Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    studentExam.examTitle,
                    style: TextStyle(
                      fontSize: 22.sp, // Slightly smaller for better balance
                      fontWeight: FontWeight.bold,
                      color: color.primaryColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: studentExam.isOnline ? Colors.green : Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          studentExam.isOnline ? Icons.wifi : Icons.wifi_off,
                          color: Colors.white,
                          size: 14.sp,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          studentExam.isOnline ? 'Online' : 'Offline',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp, // Responsive font size
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8), // Increased spacing

              // Date
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: Colors.grey,
                    size: 16.sp,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Date: ${studentExam.date}",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.sp, // Responsive font size
                      fontStyle: FontStyle.italic, // Italic for a subtle look
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16), // Increased spacing

              // Duration and Question Numbers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.timer,
                        color: color.primaryColor,
                        size: 16.sp,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Duration: ${studentExam.duration} mins",
                        style: TextStyle(
                          color: color.primaryColor,
                          fontSize: 16.sp, // Responsive font size
                          fontWeight: FontWeight.w600, // Semi-bold for emphasis
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.quiz,
                        color: color.primaryColor,
                        size: 16.sp,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Questions: ${studentExam.questionNumbers}',
                        style: TextStyle(
                          color: color.primaryColor,
                          fontSize: 16.sp, // Responsive font size
                          fontWeight: FontWeight.w600, // Semi-bold for emphasis
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12), // Increased spacing

              // Grading
              Row(
                children: [
                  Icon(
                    Icons.grade,
                    color: color.primaryColor,
                    size: 16.sp,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Grading: ${studentExam.totalMark} marks",
                    style: TextStyle(
                      color: color.primaryColor,
                      fontSize: 16.sp, // Responsive font size
                      fontWeight: FontWeight.w600, // Semi-bold for emphasis
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12), // Increased spacing

              // Location (if available)
              ///TODO:: HANDLE THIS SHIT
              if (studentExam.location == 'offline')
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: color.primaryColor,
                      size: 16.sp,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Location: ${studentExam.location}",
                      style: TextStyle(
                        color: color.primaryColor,
                        fontSize: 14.sp, // Responsive font size
                        fontWeight: FontWeight.w500, // Medium weight for subtlety
                      ),
                    ),
                  ],
                ),
          if(studentExam.isExamFinished)
              Row(
                children: [
                  Icon(
                    Icons.score,
                    color: color.primaryColor,
                    size: 16.sp,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Score: ${studentExam.score}",
                    style: TextStyle(
                      color: color.primaryColor,
                      fontSize: 16.sp, // Responsive font size
                      fontWeight: FontWeight.w600, // Semi-bold for emphasis
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if(studentExam.isExamFinished)
              Row(
                children: [
                  Icon(
                    Icons.percent,
                    color: color.primaryColor,
                    size: 16.sp,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Percentage: ${studentExam.percentage}",
                    style: TextStyle(
                      color: color.primaryColor,
                      fontSize: 16.sp, // Responsive font size
                      fontWeight: FontWeight.w600, // Semi-bold for emphasis
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if(studentExam.isExamFinished && studentExam.attended !=null)
                studentExam.attended !=null ?
                Row(
                children: [
                  Icon(
                    Icons.person,
                    color: color.primaryColor,
                    size: 16.sp,
                  ),
                  const SizedBox(width: 8),

                  Text(
                     'Attendance : ${studentExam.attended ? 'Present' : 'Absent'}',
                    style: TextStyle(
                      color: color.primaryColor,
                      fontSize: 16.sp, // Responsive font size
                      fontWeight: FontWeight.w600, // Semi-bold for emphasis
                    ),
                  )
                ],
              ): const SizedBox.shrink(),
              const SizedBox(height: 12),

              const SizedBox(height: 20), // Increased spacing

              if (studentExam.isOnline && !studentExam.isExamFinished)
                ActionButton(
                  text: 'Start',
                  onPressed:onPressed,
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  iconData: Icons.arrow_forward_ios,
                )
            ],
          ),
        ),
      ),
    );
  }
}
