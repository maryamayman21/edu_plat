import 'package:edu_platt/core/network/api_service.dart';
import 'package:edu_platt/core/network/internet_connection_service.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/cubit/dialog_cubit.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details_utils/dialog_helper_function.dart';
import 'package:edu_platt/presentation/Doctor/features/home/application/app_bar_cubit.dart';
import 'package:edu_platt/presentation/Doctor/features/home/presentation/widgets/custom_appbar.dart';
import 'package:edu_platt/presentation/Doctor/features/home/presentation/widgets/doctor_drawer.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:edu_platt/presentation/courses/data/data_source/remote_date_source.dart';
import 'package:edu_platt/presentation/courses/data/repo/courses_repoImp.dart';
import 'package:edu_platt/presentation/courses/presentaion/cubit/courses_cubit.dart';
import 'package:edu_platt/presentation/courses/presentaion/widgets/doctor_courses_success_widget.dart';
import 'package:edu_platt/presentation/courses/presentaion/widgets/no_courses_found_widegt.dart';
import 'package:edu_platt/presentation/sharedWidget/no_wifi_widget.dart';
import 'package:edu_platt/presentation/sharedWidget/text_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class DoctorHomeCoursesScreen extends StatefulWidget {
  const DoctorHomeCoursesScreen({super.key});

  @override
  State<DoctorHomeCoursesScreen> createState() => _DoctorCoursesScreenState();
}

class _DoctorCoursesScreenState extends State<DoctorHomeCoursesScreen>  with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:  (context) => AppBarCubit()..initAnimation(this),
        ),
        BlocProvider<DialogCubit>(
          create: (context) => DialogCubit(),
        ),
        BlocProvider(
          create: (context) => CoursesCubit(
              dialogCubit: context.read<DialogCubit>(),
            coursesRepoImpl: CoursesRepoImpl(
                coursesRemoteDataSource:
            CourseRemoteDataSourceImpl(ApiService()), 
                networkInfo: NetworkInfoImpl(InternetConnectionChecker())),
          )..fetchCourses()
        ),
      ],
      child: BlocListener<DialogCubit, dynamic>(
        listener: (context, state)async{
          // final dialogCubit = context.read<DialogCubit>();
          if(state?.status  == StatusDialog.SUCCESS){
            Navigator.pop(context);
            showSuccessDialog(context, message:  state?.message ?? 'Operation Successful');
          }
          if(state?.status  == StatusDialog.LOADING){
            showLoadingDialog(context);
          }
          if(state?.status  == StatusDialog.FAILURE){
            Navigator.pop(context);
            showErrorDialog(context, message:  state?.message ?? 'Something went wrong');
          }
        },
  child: Scaffold(
        drawer: const DoctorDrawer(),
        appBar: CustomAppbar(),
        body:BlocBuilder< CoursesCubit,  CoursesState>(
          builder: (context, state) {
            if(state is CoursesInitial){
               return const NoCoursesFoundWidget(
                 semesterRoute: AppRouters.doctorSemesterRoute,
               );
            }
            else if(state is CoursesLoading){
              return const Center(child: CircularProgressIndicator());
            }
            else if(state is CoursesSuccess){
               return DoctorCoursesSuccessWidget(courses: state.courses);
            }
            else if(state is CoursesFailure){
              if(state.errorMessage  == 'No internet connection'){
                 return NoWifiWidget(
                     onPressed:(){
                   context.read<CoursesCubit>().fetchCourses();
                 });
              }
              else{
                return  TextError(
                  errorMessage: state.errorMessage,
                    onPressed:(){
                      context.read<CoursesCubit>().fetchCourses();
                    }
                );
              }
            }
            else {
              return  TextError(
                errorMessage: 'Something went wrong',
                  onPressed:(){
                    context.read<CoursesCubit>().fetchCourses();
                  }
              );
            }
           },
         )
      ),
),
    );
  }
}
