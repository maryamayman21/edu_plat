
import 'package:edu_platt/presentation/Doctor/features/online_exam/domain/entity/student_degree_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentCard extends StatelessWidget {
  final StudentDegreeEntity student;
  const StudentCard({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person, size: 20.w, color: Colors.blue),
                SizedBox(width: 8.w),
                Text(student.userName, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.score, size: 20.w, color: Colors.orange),
                    SizedBox(width: 8.w),
                    Text('Score: ${student.score}', style: TextStyle(fontSize: 16.sp)),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.percent, size: 20.w, color: Colors.green),
                    SizedBox(width: 8.w),
                    Text('Percentage: ${student.scorePercentage}%', style: TextStyle(fontSize: 16.sp)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.event_available, size: 20.w, color: Colors.purple),
                    SizedBox(width: 8.w),
                    Text('Attendance:', style: TextStyle(fontSize: 16.sp)),
                  ],
                ),
                Icon(
                  student.attendance ?  Icons.cancel : Icons.check_circle,
                  color: student.attendance ? Colors.green : Colors.red,
                  size: 20.w,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
