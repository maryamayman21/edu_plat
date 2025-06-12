import 'package:edu_platt/core/network/api_service.dart';
import 'package:edu_platt/core/network/internet_connection_service.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/cubit/dialog_cubit.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details_utils/dialog_helper_function.dart';
import 'package:edu_platt/presentation/Doctor/features/home/presentation/widgets/appBar.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:edu_platt/presentation/Student/screen/levels/presentation/Studentcourses_listView.dart';
import 'package:edu_platt/presentation/courses/data/data_source/remote_date_source.dart';
import 'package:edu_platt/presentation/courses/data/repo/courses_repoImp.dart';
import 'package:edu_platt/presentation/courses/domain/entity/course_entity.dart';
import 'package:edu_platt/presentation/courses/presentaion/cubit/courses_cubit.dart';
import 'package:edu_platt/presentation/courses/presentaion/widgets/courses_grid.dart';
import 'package:edu_platt/presentation/courses/presentaion/widgets/no_courses_found_widegt.dart';
import 'package:edu_platt/presentation/sharedWidget/no_wifi_widget.dart';
import 'package:edu_platt/presentation/sharedWidget/text_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class StudentViewallcourses extends StatelessWidget {
  const StudentViewallcourses({super.key, required this.courses});

  final List<CourseEntity> courses;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<DialogCubit>(
            create: (context) => DialogCubit(),
          ),
          BlocProvider(
              create: (context) => CoursesCubit(
                    dialogCubit: context.read<DialogCubit>(),
                    coursesRepoImpl: CoursesRepoImpl(
                        coursesRemoteDataSource:
                            CourseRemoteDataSourceImpl(ApiService()),
                        networkInfo:
                            NetworkInfoImpl(InternetConnectionChecker())),
                  )..fetchCourses()),
        ],
        child: Scaffold(
            backgroundColor: const Color(0xffE6E6E6),
            appBar: MyAppBar(
              title: 'All Courses',
              onPressed: () {
                //Navigation to Courses screen
                Navigator.pushReplacementNamed(
                    context, AppRouters.HomeStudent);
              },
            ),
            body: BlocListener<DialogCubit, dynamic>(
                listener: (context, state) async {
              // final dialogCubit = context.read<DialogCubit>();
              if (state?.status == StatusDialog.SUCCESS) {
                Navigator.pop(context);
                showSuccessDialog(context,
                    message: state?.message ?? 'Operation Successful');
              }
              if (state?.status == StatusDialog.LOADING) {
                showLoadingDialog(context);
              }
              if (state?.status == StatusDialog.FAILURE) {
                Navigator.pop(context);
                showErrorDialog(context,
                    message: state?.message ?? 'Something went wrong');
              }
            }, child: BlocBuilder<CoursesCubit, CoursesState>(
              builder: (context, state) {
                if (state is CoursesInitial) {
                  return const NoCoursesFoundWidget(
                    semesterRoute: AppRouters.doctorSemesterRoute,
                  );
                } else if (state is CoursesLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CoursesSuccess) {
                  return SingleChildScrollView(
                      child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 25.h),
                    child: Column(
                      children: [
                        SizedBox(height: 15.h),
                        CoursesGrid(
                          page:AppRouters.doctorCoursesScreen, ///TODO::////
                          courses: state.courses,
                          viewAll: true,
                        ),
                      ],
                    ),
                  ));
                  //return DoctorCoursesSuccessWidget(courses: state.courses);
                } else if (state is CoursesFailure) {
                  if (state.errorMessage == 'No internet connection') {
                    return NoWifiWidget(
                        onPressed: () {
                      context.read<CoursesCubit>().fetchCourses();
                    }
                    );
                  } else {
                    return TextError(
                      errorMessage: state.errorMessage,
                        onPressed: () {
                          context.read<CoursesCubit>().fetchCourses();
                        }
                    );
                  }
                } else {
                  return TextError(
                    errorMessage: 'Something went wrong',
                      onPressed: () {
                        context.read<CoursesCubit>().fetchCourses();
                      }
                  );
                }
              },
            ))));
  }
}
