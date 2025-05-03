
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ResultDialog extends StatelessWidget {
  final int correctAnswers;
  final int totalScore;
  final int earnedScore;

  ResultDialog(
      {required this.correctAnswers,
      required this.totalScore,
      required this.earnedScore});

  @override
  Widget build(BuildContext context) {
    double percentage = earnedScore / totalScore;

    return AlertDialog(


      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        "Exam Completed",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 22.sp, color: color.primaryColor),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularPercentIndicator(
            radius: 100.r,
            lineWidth: 25.w,
            percent: percentage,
            center: Text(
              "${(percentage * 100).toStringAsFixed(1)}%",
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
            ),
            progressColor: Colors.green,
            backgroundColor: Colors.grey[300]!,
            circularStrokeCap: CircularStrokeCap.round,
          ),
          SizedBox(height: 20.h),
          Text(
            "Correct Answers: $correctAnswers",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.h),
          Text(
            "Your Score: $earnedScore / $totalScore",
            style: TextStyle(fontSize: 18.sp, color: Colors.blueAccent),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        Row(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, AppRouters.HomeStudent); // الخروج من صفحة الامتحان
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                "Exit",
                style: TextStyle(fontSize: 16.sp, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
