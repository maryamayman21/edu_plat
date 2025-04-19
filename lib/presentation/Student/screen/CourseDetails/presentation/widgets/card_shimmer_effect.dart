import 'package:edu_platt/presentation/Student/screen/CourseDetails/presentation/widgets/course_details_shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CardShimmerEffect extends StatelessWidget {
  const CardShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: REdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               CourseDetailsShimmerEffect(width: 120.w, height: 20.h),
                CourseDetailsShimmerEffect(width: 120.w, height: 20.h)
              ],
            ),
             SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CourseDetailsShimmerEffect(width: 120.w, height: 20.h),
                CourseDetailsShimmerEffect(width: 120.w, height: 20.h)
              ],
            ),
             SizedBox(height: 30.h),

            // Table for Marks
            CourseDetailsShimmerEffect(width: double.infinity, height: 120.h)

          ],
        ),
      ),
    );
  }
}
