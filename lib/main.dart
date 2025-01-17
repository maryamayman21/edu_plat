
import 'package:edu_platt/config/theme/theme.dart';
import 'package:edu_platt/core/cashe/services/notes_cache_service.dart';
import 'package:edu_platt/presentation/Auth/service/token_service.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:edu_platt/presentation/Student/screen/notes/cubit/notes_cubit.dart';
import 'package:edu_platt/presentation/Student/screen/notes/data/notes_repository/notes_repository.dart';
import 'package:edu_platt/presentation/Student/screen/notes/data/notes_web_service/notes_web_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) =>
          BlocProvider(
            create: (context) => NotesCubit( tokenService:TokenService() , notesCacheService:NotesCacheService() , notesRepository:NotesRepository(NotesWebService()) )..getAllNotes(),
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: AppTheme.theme,
                initialRoute: AppRouters.splashRoute,
                onGenerateRoute: AppRouters.generateRoute
              //   (setting) {
              // switch (setting.name) {
              //   case AppRouters.registerRoute:
              //     return MaterialPageRoute(
              //       builder: (context) => RegisterScreen(),
              //     );
              //   case AppRouters.loginStudentRoute:
              //     return MaterialPageRoute(
              //       builder: (context) => const LoginScreenStudent(),
              //     );
              //   case AppRouters.loginDoctorRoute:
              //     return MaterialPageRoute(
              //       builder: (context) => const LoginScreenDoctor(),
              //     );
              //   case AppRouters.splashRoute:
              //     return MaterialPageRoute(
              //       builder: (context) => const Splash(),
              //     );
              //   case AppRouters.onBoardRoute:
              //     return MaterialPageRoute(
              //       builder: (context) => const onboarding(),
              //     );
              //     case AppRouters.studentOrDoctor:
              //     return MaterialPageRoute(
              //       builder: (context) => const StudentOrDoctor() ,
              //     );
              //   case AppRouters.forgetPassword:
              //     return MaterialPageRoute(
              //       builder: (context) => const Forgetpassword(),
              //     );
              //   case AppRouters.verifyPassword:
              //     return MaterialPageRoute(
              //       builder: (context) => const Verifypassword(),
              //     );
              //   case AppRouters.setPassword:
              //     return MaterialPageRoute(
              //       builder: (context) => const Setpassword(),
              //     );
              //   case AppRouters.passwordResetSuccess:
              //     return MaterialPageRoute(
              //       builder: (context) => const PasswordResetSuccess(),
              //     );
              //   case AppRouters.HomeStudent:
              //     return MaterialPageRoute(
              //       builder: (context) => const HomeStudentScreen(),
              //     );
              //   case AppRouters.doctorCoursesRegisterSuccessRoute :
              //     return MaterialPageRoute(
              //         builder: (context) => const Courseregisteredscuccess()
              //     );
              //   case AppRouters.doctorCourseRegisterationRoute:
              //     return MaterialPageRoute(
              //       builder: (context) => Courseregisterationscreen(),
              //     );
              //   case AppRouters.doctorHomeRoute:
              //     return MaterialPageRoute(
              //       builder: (context) => HomeScreen(),
              //     );
              //   case AppRouters.doctorViewAllCoursesRoute :
              //     return MaterialPageRoute(
              //         builder: (context) => const Viewallcourses()
              //     );
              //   case AppRouters.doctorSemesterRoute :
              //     return MaterialPageRoute(
              //         builder: (context) => const Semesterscreen()
              //     );
              //
              //   case AppRouters.level1:
              //     return MaterialPageRoute(builder: (context) => const Level1());
              //   case AppRouters.level2:
              //     return MaterialPageRoute(builder: (context) => const Level2());
              //    case AppRouters.level3:
              //      return MaterialPageRoute(builder: (context) => const Level3());
              //    case AppRouters.level4:
              //     return MaterialPageRoute(builder: (context) => const Level4());
              //    case AppRouters.ExamScreen:
              //      return MaterialPageRoute(
              //         builder: (context) => const Examscreen());
              //    case AppRouters.ExamDetails:
              //      return MaterialPageRoute(
              //          builder: (context) => const Examdetails());
              // }

            ),
          ),
    );
  }
}
