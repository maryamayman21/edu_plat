
import 'package:edu_platt/presentation/Student/screen/home/homeStudent.dart';
import 'package:flutter/material.dart';

import '../Auth/presentation/loginStudent/loginStudent.dart';
import '../Auth/presentation/register/register.dart';
import '../Auth/presentation/register/verify_email.dart';
import '../Doctor/features/courseRegisteration/presentation/screens/courseRegisterationScreen.dart';
import '../Doctor/features/courseRegisteration/presentation/screens/courseRegisteredScuccess.dart';
import '../Doctor/features/courseRegisteration/presentation/screens/semesterScreen.dart';
import '../Doctor/features/courses/presentation/screens/course_details.dart';
import '../Doctor/features/courses/presentation/screens/file_preview.dart';
import '../Doctor/features/courses/presentation/screens/viewAllCourses.dart';
import '../Doctor/features/courses/presentation/widgets/uploadFile_headr.dart';
import '../Doctor/features/home/presentation/screens/home_screen.dart';
import '../Doctor/screen/exam/exam.dart';
import '../Student/screen/CourseDetails/courseDetails.dart';
import '../Student/screen/exam/examDetails.dart';
import '../Student/screen/exam/examScreen.dart';
import '../Student/screen/exam/startExam/StartExam.dart';
import '../Student/screen/levels/levelsDetails/level1/level1.dart';
import '../Student/screen/levels/levelsDetails/level2/level2.dart';
import '../Student/screen/levels/levelsDetails/level3/level3.dart';
import '../Student/screen/levels/levelsDetails/level4/level4.dart';
import '../forgetAndResetPassword/presentation/forgetPassword.dart';
import '../forgetAndResetPassword/presentation/passwordResetSucc.dart';
import '../forgetAndResetPassword/presentation/setPassword.dart';
import '../forgetAndResetPassword/presentation/verifyPassword.dart';
import '../onBoarding/onBoarding.dart';
import '../profile/changePassword.dart';
import '../profile/change_password-success.dart';
import '../sharedWidget/Student_Doctor.dart';
import '../splash/splash.dart';
import 'custom_pageRoute.dart';

class AppRouters {
  static const String homeRoute = '/';
  static const String registerRoute = '/registerScreen';
  static const String onBoardRoute = '/onBoardRoute';
  static const String loginStudentRoute = '/loginStudentRoute';
  static const String loginDoctorRoute = '/loginDoctorRoute';
  static const String splashRoute = '/splashRoute';
  static const String studentOrDoctor = '/studentOrDoctor';
  static const String forgetPassword = '/forgetPassword';
  static const String verifyPassword = '/verifyPassword';
  static const String setPassword = '/setPassword';
  static const String passwordResetSuccess = '/passwordResetSuccess';
  static const String verifyEmail = '/verifyEmail';
  static const String HomeStudent = '/HomeStudent';
 // static const String level = '/level';
  static const String level1 = '/level1';
  static const String level2 = '/level2';
  static const String level3 = '/level3';
  static const String level4 = '/level4';
  static const String ExamScreen = '/ExamScreen';
  static const String ExamDetails = '/ExamDetails';
  static const String doctorProfileRoute = '/doctorProfileRoute';
  static const String doctorChatRoute = '/doctorChatRoute';
  static const String doctorHomeRoute = '/doctorHomeRoute';
  static const String doctorCourseRegisterationRoute = '/doctorCourseRegisterRoute';
  static const String doctorViewAllCoursesRoute = '/doctorViewAllCoursesRoute';
  static const String doctorSemesterRoute = '/doctorSemesterRoute';
  static const String doctorCoursesRegisterSuccessRoute = '/doctorCourseRegisterSuccessRoute';
  static const String doctorCourseDetailsRoute = '/doctorCourseDetailsRoute';
  static const String doctorCourseContentPreview ='/doctorCourseContentPreview';
  static const String studentCourseDetails = '/studentCourseDetails';
  static const String changePasswordRoute = '/changePasswordRoute';
  static const String changePasswordSuccRoute = '/changePasswordSuccRoute';
  static const String StartExam = '/startExamRoute';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case registerRoute:
        return CustomPageRoute(page: RegisterScreen());
      case loginStudentRoute:
        final isDoctor = settings.arguments as bool;
        return CustomPageRoute(page:  LoginScreenStudent( isDoctor: isDoctor,));
      // case loginDoctorRoute:
      //   return CustomPageRoute(page: const LoginScreenDoctor());
      case splashRoute:
        return MaterialPageRoute(builder: (context) => const Splash(),);
      case onBoardRoute:
        return MaterialPageRoute(builder: (context) => const onboarding(),);
      case studentOrDoctor:
        return MaterialPageRoute(builder: (context) => const StudentOrDoctor(),);
      case forgetPassword:
        return CustomPageRoute(page: const Forgetpassword());
      case verifyPassword:
         final userEmail  = settings.arguments as String ;
        return CustomPageRoute(page:  Verifypassword(userEmail:  userEmail,));
      case setPassword:
        return CustomPageRoute(page: const Setpassword());
      case passwordResetSuccess:
        return MaterialPageRoute(builder: (context) =>  const PasswordResetSuccess(),);
      case doctorCoursesRegisterSuccessRoute:
        return MaterialPageRoute(builder: (context) => const Courseregisteredscuccess(),);
      case doctorCourseRegisterationRoute:
        final semesterID = settings.arguments as int;
        return CustomPageRoute(page: Courseregisterationscreen(semesterID: semesterID,));
      case doctorHomeRoute:
        return MaterialPageRoute(builder: (context) => HomeScreen(),);
      case doctorViewAllCoursesRoute:
        return CustomPageRoute(page: const Viewallcourses());
      case doctorSemesterRoute:
        return CustomPageRoute(page: const Semesterscreen());
      case doctorCourseDetailsRoute:
        final courseCode = settings.arguments as String;
        return CustomPageRoute(
          page: CourseDetails(courseCode: courseCode),
        );
      case doctorCourseContentPreview:
        final file = settings.arguments as FileData;
        return CustomPageRoute(
          page:FilePreview(fileData: file,),
        );
       case level1 :
         String levelText = settings.arguments as String;
         return CustomPageRoute(page:  Level1(levelNumber: levelText,));
      case level2 :
        return CustomPageRoute(page: const Level2());
      case level3 :
        return CustomPageRoute(page: const Level3());
      case level4 :
        return CustomPageRoute(page: const Level4());
      case verifyEmail :
        final userDate = settings.arguments as List<String>;
        return CustomPageRoute(page:VerifyEmail( arguemnt: userDate,));
      case studentCourseDetails :
        final courseCode = settings.arguments as String;
        final creditHours = settings.arguments as String;
        final courseDescription = settings.arguments as String;
        return CustomPageRoute(page: Coursedetails());
      case ExamScreen:
        return CustomPageRoute(page: const Examscreen());
      case ExamDetails:
        return MaterialPageRoute(
            builder: (context) => const Examdetails());
      case StartExam:
        return CustomPageRoute(page: const Startexam());

      case HomeStudent:
        return MaterialPageRoute(
            builder: (context) => const HomeStudentScreen());
      case changePasswordRoute:
        return CustomPageRoute(page: const Changepassword());
      case changePasswordSuccRoute:
        return MaterialPageRoute(
            builder: (context) => const ChangePasswordSuccess());
      default:
        return CustomPageRoute(page: const DoctorExamScreen());
    }
  }
}
