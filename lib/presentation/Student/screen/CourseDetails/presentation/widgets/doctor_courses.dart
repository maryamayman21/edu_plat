import 'package:edu_platt/core/utils/Assets/appAssets.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/domain/entity/doctor_courses_entity.dart';
import 'package:edu_platt/presentation/courses/domain/entity/course_entity.dart';
import 'package:edu_platt/presentation/sharedWidget/animated_widegt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DoctorCoursesWidget extends StatefulWidget {
  const DoctorCoursesWidget ({super.key, required this.doctorCoursesEntity, required this.courseDetail});
   final DoctorCoursesEntity doctorCoursesEntity;
   final CourseEntity courseDetail;
  @override
  State<DoctorCoursesWidget> createState() => _DoctorCoursesState();
}

class _DoctorCoursesState extends State<DoctorCoursesWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainerWidget(
      vsync: this,
      startOffset: const Offset(-1, 0),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRouters.studentCourseDetails,
              arguments:
              {
                'doctorId' : widget.doctorCoursesEntity.doctorId,
                'courseEntity' : widget.courseDetail
              },
            );
          },
          style: ElevatedButton.styleFrom(
            elevation: 10,
            shadowColor: Colors.black.withOpacity(1),
            minimumSize: Size(100.w, 130.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10).r,
            ),
          ),
          child: Text(
            widget.doctorCoursesEntity.doctorName,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: color.primaryColor,
              fontFamily: 'Roboto-Mono',
              shadows: [
                Shadow(
                  color: Colors.grey.withOpacity(1),
                  offset: const Offset(2, 2),
                  blurRadius: 10.r,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
