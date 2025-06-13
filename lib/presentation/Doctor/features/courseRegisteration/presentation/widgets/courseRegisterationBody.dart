import 'package:edu_platt/presentation/Doctor/features/courseRegisteration/data/models/course.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/cubit/dialog_cubit.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details_utils/dialog_helper_function.dart';
import 'package:edu_platt/presentation/sharedWidget/text_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/DataModel/courseModel.dart';
import '../../../../../../core/utils/Assets/appAssets.dart';
import '../../../../../sharedWidget/buttons/custom_button.dart';
import '../../../home/application/app_bar_cubit.dart';
import '../../../home/presentation/widgets/custom_appbar.dart';

import '../../application/cubit/course_registeration_cubit.dart';
import '../../application/cubit/dropdown_cubit.dart';
import '../../application/cubit/dropdown_state.dart';

import 'dropdown_list.dart';
import 'dropdown_toggle.dart';

class CourseRegisterationBody extends StatefulWidget {
  CourseRegisterationBody({super.key, required this.semesterID});

  final int semesterID;

  @override
  State<CourseRegisterationBody> createState() =>
      _CourseRegisterationBodyState();
}

class _CourseRegisterationBodyState extends State<CourseRegisterationBody>
    with TickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseRegisterationCubit, CourseRegisterationState>(
        builder: (context, state) {
          if (state is CourseRegisterationSuccess) {
            List<Course> level1Courses = state.level1Courses;
            List<Course> level2Courses = state.leve21Courses;
            List<Course> level3Courses = state.leve31Courses;
            List<Course> level4Courses = state.leve41Courses;


            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const SizedBox(
                    height: 32,
                  ),
                  const DropdownToggle(id: 'Level 1'),
                  DropdownList(id: 'Level 1', courses: level1Courses),
                  const DropdownToggle(id: 'Level 2'),
                  DropdownList(id: 'Level 2', courses: level2Courses),
                  const DropdownToggle(id: 'Level 3'),
                  DropdownList(id: 'Level 3', courses: level3Courses),
                  const DropdownToggle(id: 'Level 4'),
                  DropdownList(id: 'Level 4', courses: level4Courses),
                ],
              ),
            );
          }
          else if (state is CourseRegisterationLoading) {
            return const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          }
          else if (state is CourseRegisterationFailure) {
            return TextError(
                onPressed: () {
                  BlocProvider
                      .of<CourseRegisterationCubit>(context)
                      .fetchRegistrationCourses(widget.semesterID);
                }, errorMessage: state.errorMessage);
          }
          else {
            return TextError(
                onPressed: () {
                  BlocProvider
                      .of<CourseRegisterationCubit>(context)
                      .fetchRegistrationCourses(widget.semesterID);
                }, errorMessage: 'Something went wrong');
          }
        });
  }
}
