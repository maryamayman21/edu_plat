
import 'package:edu_platt/presentation/Auth/service/token_service.dart';
import 'package:edu_platt/presentation/Doctor/features/home/presentation/widgets/appBar.dart';
import 'package:edu_platt/presentation/Student/screen/StudentCourseRegister/Cubit/Student_Course_RegisterCubit.dart';
import 'package:edu_platt/presentation/Student/screen/StudentCourseRegister/Cubit/dropdown_cubit.dart';
import 'package:edu_platt/presentation/Student/screen/StudentCourseRegister/Widget/Acton_Button.dart';
import 'package:edu_platt/presentation/Student/screen/StudentCourseRegister/Widget/course_body.dart';
import 'package:edu_platt/presentation/Student/screen/StudentCourseRegister/data/reposatories/repo.dart';
import 'package:edu_platt/presentation/Student/screen/StudentCourseRegister/data/web_Server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/cashe/services/course_cashe_service.dart';


class StudentCourseregisteration extends StatelessWidget {
  final semesterID;
  StudentCourseregisteration({super.key, required this.semesterID});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DropdownCubit>(
          create: (context) => DropdownCubit(),
        ),
        BlocProvider<StudentCourseRegisterationCubit>(
            create: (context) => StudentCourseRegisterationCubit(
                studentcourseRegistrationRepository:
                StudentCourseRegistrationRepository(StudentCourseRegistrationWebService()),
                tokenService:TokenService() , courseCacheService: CourseCacheService())..fetchRegistrationCourses(semesterID),
    ),
      ],
      child: Scaffold(
        appBar: MyAppBar(
          title: 'Courses Registration',
          onPressed: () {
            //Navigation to Courses screen
            Navigator.pop(context);
          },
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: StudentCourseRegisterationBody(semesterID:semesterID ,),
        ),
        bottomNavigationBar: const StudentCourseRegisterationActionButtons(),
      ),
    );
  }
}

