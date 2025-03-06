import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogWidget extends StatelessWidget {
  final String totalCourses;
  final String totalCredits;
  final String totalPoints;
  final String cgpa;
   DialogWidget({required this.totalCourses,
    required this.totalCredits,
    required this.totalPoints,
    required this.cgpa, });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Calculation Details!",
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                color: color.primaryColor,
              ),
            ),
            SizedBox(height: 20.h),
            _buildDetailRow("Total Courses :", totalCourses),
            _buildDetailRow("Total Credits :", totalCredits),
            _buildDetailRow("Total Points :", totalPoints),
            Divider(thickness: 1, color: Colors.grey),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "CGPA",
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                Text(
                  cgpa,
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                    child: Text(
                      "ok",
                      style: TextStyle(fontSize: 20.sp, color: color.primaryColor,fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold,color: color.primaryColor),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.pinkAccent,),
          ),
        ],
      ),
    );
  }
}