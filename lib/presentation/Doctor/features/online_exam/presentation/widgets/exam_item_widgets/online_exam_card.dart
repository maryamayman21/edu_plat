import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/domain/entity/exam_entity.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/exam_item_widgets/view_student_degrees_button.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:edu_platt/presentation/sharedWidget/buttons/action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnlineExamCard extends StatelessWidget {
  const OnlineExamCard({super.key, required this.onPressed, required this.examEntity});
    final ExamEntity examEntity;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w , vertical: 10.h),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.w , vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and Online/Offline Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    examEntity.examTitle,
                    style: TextStyle(
                      fontSize: 22.sp, // Slightly smaller for better balance
                      fontWeight: FontWeight.bold,
                      color: color.primaryColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color:  Colors.green ,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                         Icons.wifi,
                          color: Colors.white,
                          size: 14.sp,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Online',
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
                    "Date: ${examEntity.date}",
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
                        "Duration: ${examEntity.duration} min",
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
                        'Questions: ${examEntity.questionNumbers}',
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
                    "Grading: ${examEntity.totalMark} marks",
                    style: TextStyle(
                      color:color.primaryColor,
                      fontSize: 16.sp, // Responsive font size
                      fontWeight: FontWeight.w600, // Semi-bold for emphasis
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12), // Increased spacing


              const SizedBox(height: 20), // Increased spacing

              // Button for Online Exams
              if (examEntity.isExamFinished)
                Align(
                  alignment: Alignment.center,
                  child: ActionButton(
                    text: 'View Students Degrees',
                    onPressed: (){
                      Navigator.pushNamed(context, AppRouters.doctorStudentDegreesScreen, arguments: examEntity.examId);

                    },
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    iconData:Icons.arrow_forward_ios ,
                  ),
                ),
              if(!examEntity.isExamFinished)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ActionButton(
                      text: 'Edit',
                      onPressed: (){

                        Navigator.pushNamed(context, AppRouters.doctorOnlineExamEditScreen, arguments: examEntity.examId);
                      },
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      iconData:Icons.edit ,
                    ),
                    ActionButton(
                      text: 'Discard',
                      onPressed:onPressed,
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      iconData:Icons.remove ,
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
