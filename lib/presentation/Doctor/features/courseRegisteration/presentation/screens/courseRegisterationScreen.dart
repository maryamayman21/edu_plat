import 'package:edu_platt/presentation/Doctor/features/home/presentation/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/cashe/services/course_cashe_service.dart';
import '../../../../../Auth/service/token_service.dart';
import '../../../../../Routes/appRouts.dart';
import '../../application/cubit/course_registeration_cubit.dart';
import '../../application/cubit/dropdown_cubit.dart';
import '../../data/data_source/web_service.dart';
import '../../data/repositories/repository.dart';
import '../widgets/courseRegisterActionButtons.dart';
import '../widgets/courseRegisterationBody.dart';

class Courseregisterationscreen extends StatelessWidget {
  final semesterID;
  Courseregisterationscreen({super.key, required this.semesterID});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DropdownCubit>(
          create: (context) => DropdownCubit(),
        ),
        BlocProvider<CourseRegisterationCubit>(
          create: (context) => CourseRegisterationCubit(
              courseRegistrationRepository:
                  CourseRegistrationRepository(CourseRegistrationWebService()),
              tokenService: TokenService() , courseCacheService: CourseCacheService())..fetchRegistrationCourses(semesterID)
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
          child: CourseRegisterationBody(semesterID:semesterID ,),
        ),
        bottomNavigationBar: const CourseRegisterationActionButtons(),
      ),
    );
  }
}
