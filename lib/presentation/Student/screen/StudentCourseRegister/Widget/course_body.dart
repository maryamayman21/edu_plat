import 'package:edu_platt/core/utils/Assets/appAssets.dart';
import 'package:edu_platt/presentation/Doctor/features/courseRegisteration/data/models/course.dart';
import 'package:edu_platt/presentation/Student/screen/StudentCourseRegister/Cubit/Student_Course_RegisterCubit.dart';
import 'package:edu_platt/presentation/Student/screen/StudentCourseRegister/Widget/dropdown_list.dart';
import 'package:edu_platt/presentation/Student/screen/StudentCourseRegister/Widget/dropdown_toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../sharedWidget/buttons/custom_button.dart';


class StudentCourseRegisterationBody extends StatefulWidget {
  StudentCourseRegisterationBody({super.key, required this.semesterID});
  final int semesterID;
  @override
  State<StudentCourseRegisterationBody> createState() =>
      _StudentCourseRegisterationBodyState();
}

class _StudentCourseRegisterationBodyState extends State<StudentCourseRegisterationBody>
    with TickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentCourseRegisterationCubit, StudentCourseRegisterationState>(
        builder: (context, state) {
          if(state is CourseRegisterationSuccess) {
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
          else if(state is CourseRegisterationLoading){
            return const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          }
          else if(state is CourseRegisterationFailure){
            return Column(
              children: [
                Center(child: Image.asset(AppAssets.noWifiConnection)),
                const Text('No internet connection',
                  style: TextStyle(
                      color: Colors.black
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 40),
                  child: CustomButtonWidget(
                    onPressed: () {
                      context.read<StudentCourseRegisterationCubit>().fetchRegistrationCourses(widget.semesterID);
                    },
                    child: const Text('Retry',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                )

              ],
            );

          }
          return const Center(
            child: Text('Something went wrong',
              style: TextStyle(
                  color: Colors.black
              ),
            ),
          );
        });
  }
}
