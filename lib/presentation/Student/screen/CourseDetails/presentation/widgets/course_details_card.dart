import 'package:edu_platt/core/network/api_service.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/data/repo/course_details_repoImp.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/courseDetails.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/presentation/cubit/course_files_cubit.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/presentation/cubit/material_type_cubit.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/presentation/widgets/detail_icon_text.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/presentation/widgets/table_mark.dart';
import 'package:edu_platt/presentation/Student/screen/group_chat/groupList/GroupMember.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../../../core/network/internet_connection_service.dart';
import '../../../../../Doctor/features/course_details/data/data_source/remote_data_source.dart';


class CourseDetailsCard extends StatelessWidget {
  final String courseTitle;
  final int creditHours;
  final int lectures;
  final String doctorName;
  final Map<String, dynamic>marks;
  final String courseCode;


  const CourseDetailsCard({
    Key? key,
    required this.courseTitle,
    required this.creditHours,
    required this.lectures,
    required this.doctorName,
    required this.marks,
    required this.courseCode
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w), // Responsive padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Course Title
              Text(
              courseTitle,
                style: TextStyle(
                  color: color.primaryColor,
                  fontSize: 22.sp,
                ),
              ),
              SizedBox(height: 16.h), // Responsive spacing

              // First Row: Credit Hours and Lectures
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DetailIconText(
                    icon: Icons.lock_clock,
                    text: '$creditHours Credit Hours',
                  ),
                  DetailIconText(
                    icon: Icons.library_books,
                    text: '$lectures Lectures',
                  ),
                ],
              ),
              SizedBox(height: 24.h), // Responsive spacing

              // Second Row: Grades and Chat with Doctor
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DetailIconText(
                    icon: Icons.check_circle_outline,
                    text: 'Grades',
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => GroupMember(
                            courseCode: courseTitle,
                          ),
                        ),
                      );

                    },
                    child: DetailIconText(
                      icon: Icons.chat,
                      text: 'Chat          ',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h), // Responsive spacing

              // Table for Marks
              TableMark(
                marks: marks,
              ),
            ],
          ),
        ),

    );
  }
}