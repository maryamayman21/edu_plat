
import 'package:edu_platt/core/cashe/services/course_cashe_service.dart';
import 'package:edu_platt/core/utils/Assets/appAssets.dart';
import 'package:edu_platt/presentation/Auth/service/token_service.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:edu_platt/presentation/Student/screen/levels/cubit/Studentcourses_cubit.dart';
import 'package:edu_platt/presentation/Student/screen/levels/data/data_source/course_web_service.dart';
import 'package:edu_platt/presentation/Student/screen/levels/data/repositories/course_repository.dart';
import 'package:edu_platt/presentation/Student/screen/levels/presentation/StudentCourses_Grid.dart';
import 'package:edu_platt/presentation/sharedWidget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/Color/color.dart';
import '../../../../../../core/utils/customDialogs/custom_dialog.dart';

class StudentCoursesListview extends StatelessWidget {
  StudentCoursesListview({super.key, this.viewAll = false, required this.page,});

  final bool viewAll;
  final String page;


  @override
  Widget build(BuildContext cxt) {
    return BlocProvider(
      create: (context) =>StudentCoursesCubit(
        tokenService: TokenService(),
         courseRepository: StudentCourseRepository(StudentCourseWebService()) ,
        courseCacheService: CourseCacheService() ,

      ) ..getCourses(),

      child: BlocConsumer<StudentCoursesCubit, StudentCoursesState>(
          listener: (context, state) {
            // // TODO: implement listener
            if (state is CoursesLoading) {
              CustomDialogs.showLoadingDialog(context: cxt);
            } else if (state is CoursesDeletionFailure) {
              Navigator.pop(context);
              CustomDialogs.showErrorDialog(context: cxt,
                  title: 'Confirm Action',
                  message: 'Failed to delete course, Try again.');
            }
            else if (state is CourseDeletionSuccess) {
              Navigator.pop(context);
              CustomDialogs.showSuccessDialog(
                  context: cxt,
                  title: "Confirm Action",
                  message: state.successMessage
              );
            }
            else if(state is CoursesFailure){
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('${state.errorMessage}')));
            }

          },
          builder: (context, state) {
            if (state is CoursesSuccess) {
              final courses = state.courses ?? [];
              final finalCourses = viewAll ? courses : courses.take(2)
                  .toList();
              return StudentCoursesGrid(
                  viewAll: viewAll, page: page, finalCourses: finalCourses);
            }
            else if (state is CoursesNotFound) {
              return   Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  viewAll ? const SizedBox(height: 190) : const SizedBox.shrink(),
                  Image.asset(AppAssets.books),
                  const Text(
                    'No courses yet.',
                    style: TextStyle(
                      color: color.primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: CustomButtonWidget(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRouters.studentSemesterRoute);
                      },
                      child: const Text(
                        'Register Courses',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            else if (state is CoursesLoading) {
              return StudentCoursesGrid(viewAll: viewAll,
                page: page,
                finalCourses: state.courses ?? [],);

            }
            else if(state is GetCoursesLoading ){
              return const CircularProgressIndicator();
            }
            else if (state is CoursesDeletionFailure) {
              return StudentCoursesGrid(viewAll: viewAll,
                page: page,
                finalCourses: state.courses ?? [],);
            } else if (state is CourseDeletionSuccess) {
              return StudentCoursesGrid(viewAll: viewAll,
                page: page,
                finalCourses: state.courses ?? [],);
            }
            else if(state is CoursesFailure){
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top:60.0),
                    child: const Text('No internet connection',
                      style: TextStyle(
                          color: Colors.black,fontWeight: FontWeight.bold,fontSize: 22
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    child: CustomButtonWidget(
                      onPressed: () {
                        context.read<StudentCoursesCubit>().getCourses();
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

            else {
              return const Text('Something went wrong',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              );
            }
          }


      ),

    );
  }


    void _showLoadingDialog(BuildContext context) {
      CustomDialogs.showLoadingDialog(context: context);
    }

    void _showErrorDialog(BuildContext context, String title, String message) {
      CustomDialogs.showErrorDialog(
          context: context, title: title, message: message);
    }

    void _showSuccessDialog(BuildContext context, String title,
        String message) {
      CustomDialogs.showSuccessDialog(
          context: context, title: title, message: message);
    }

    Widget _buildNoCoursesFound(BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          viewAll ? const SizedBox(height: 190) : const SizedBox.shrink(),
          Image.asset(AppAssets.books),
          const Text(
            'No courses yet.',
            style: TextStyle(
              color: color.primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: CustomButtonWidget(
              onPressed: () {
                Navigator.pushNamed(context, AppRouters.studentSemesterRoute);
              },
              child: const Text(
                'Register Courses',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      );
    }
  }





