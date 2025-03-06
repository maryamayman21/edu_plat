import 'package:edu_platt/presentation/Private_chat/privateChat.dart';
import 'package:edu_platt/presentation/Student/screen/GPA/C_Gpa.dart';
import 'package:edu_platt/presentation/Student/screen/StudentCourseRegister/RegisterCourse/StudentCourseRegisteration.dart';
import 'package:edu_platt/presentation/Student/screen/StudentCourseRegister/RegisterCourse/StudentcourseRegisteredScuccess.dart';
import 'package:edu_platt/presentation/Student/screen/StudentCourseRegister/StudentSemesterScreen/StudentSemesterScreen.dart';
import 'package:edu_platt/presentation/Private_chat/Chat_List.dart';
import 'package:edu_platt/presentation/Student/screen/chat/chatScreen.dart';
import 'package:edu_platt/presentation/Student/screen/home/homeStudent.dart';
import 'package:edu_platt/presentation/Student/screen/levels/presentation/Studentcourse_details.dart';
import 'package:edu_platt/presentation/Student/screen/levels/presentation/StudentviewAllCourses.dart';
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
  static const String StudentChatScreen = '/SchatScreen';
  static const String GeneralChatScreen = '/GeneralChat';
  static const String ExamScreen = '/ExamScreen';
  static const String ExamDetails = '/ExamDetails';
  static const String doctorProfileRoute = '/doctorProfileRoute';
  static const String doctorChatRoute = '/doctorChatRoute';
  static const String doctorHomeRoute = '/doctorHomeRoute';
  static const String studentCourseRegisterationRoute = '/studentCourseRegisterRoute';
  static const String doctorCourseRegisterationRoute = '/doctorCourseRegisterRoute';
  static const String doctorViewAllCoursesRoute = '/doctorViewAllCoursesRoute';
  static const String doctorSemesterRoute = '/doctorSemesterRoute';
  static const String doctorCoursesRegisterSuccessRoute = '/doctorCourdoctorCourseDetailsRouteseRegisterSuccessRoute';
  static const String doctorCourseDetailsRoute = '/';
  static const String doctorCourseContentPreview ='/doctorCourseContentPreview';
  static const String studentCourseDetails = '/studentCourseDetails';
  static const String changePasswordRoute = '/changePasswordRoute';
  static const String changePasswordSuccRoute = '/changePasswordSuccRoute';
  static const String StartExam = '/startExamRoute';
  static const String GPA = '/GPA';
  static const String studentCoursesRegisterSuccessRoute = '/studentCoursesRegisterSuccessRoute';
  static const String studentSemesterRoute = '/studentSemesterRoute';
  static const String studentViewAllCoursesRoute="/studentViewAllCoursesRoute";
  static const String studentCourseDetailsRoute="/studentCourseDetailsRoute";
  static const String privateChat = '/privateChat';





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
      case StudentChatScreen:
        return MaterialPageRoute(builder: (context) =>  ChatList(),);
      case Privatechat:
        final roomId = settings.arguments as String;
        return MaterialPageRoute(builder: (context) =>  Privatechat(roomId: roomId),);
      case GeneralChatScreen:
        return MaterialPageRoute(builder: (context) =>  ChatScreen());
      case onBoardRoute:
        return MaterialPageRoute(builder: (context) => const onboarding(),);
      case studentOrDoctor:
        return MaterialPageRoute(builder: (context) => const StudentOrDoctor(),);
      case forgetPassword:
        return CustomPageRoute(page: const Forgetpassword());
      case verifyPassword:
         final userEmail  = settings.arguments  as String? ?? "" ;
        return CustomPageRoute(page:  Verifypassword(userEmail:  userEmail,));
      case setPassword:
        return CustomPageRoute(page: const Setpassword());
      case passwordResetSuccess:
        return MaterialPageRoute(builder: (context) =>  const PasswordResetSuccess(),);
      case doctorCoursesRegisterSuccessRoute:
        return MaterialPageRoute(builder: (context) => const Courseregisteredscuccess(),);
      case studentCoursesRegisterSuccessRoute:
        return MaterialPageRoute(builder: (context) => const StudentCourseregisteredscuccess(),);
      case doctorCourseRegisterationRoute:
        final semesterID = settings.arguments as int;
        return CustomPageRoute(page: Courseregisterationscreen(semesterID: semesterID,));
      case studentCourseRegisterationRoute:
        final semesterID = settings.arguments as int;
        return CustomPageRoute(page: StudentCourseregisteration(semesterID: semesterID,));
      case doctorHomeRoute:
        return MaterialPageRoute(builder: (context) => HomeScreen(),);
      case doctorViewAllCoursesRoute:
        return CustomPageRoute(page: const Viewallcourses());
      case studentViewAllCoursesRoute:
        return CustomPageRoute(page: const StudentViewallcourses());
      case doctorSemesterRoute:
        return CustomPageRoute(page: const Semesterscreen());
      case studentSemesterRoute:
        return CustomPageRoute(page: const StudentSemesterscreen());
      case doctorCourseDetailsRoute:
        final courseCode = settings.arguments as String? ?? "default_code";
        return CustomPageRoute(
          page: CourseDetails(courseCode: courseCode),
        );
      case studentCourseDetailsRoute:
        final courseCode = settings.arguments as String? ?? "default_code";
        return CustomPageRoute(
          page: StudentCourseDetails(courseCode: courseCode),
        );
      case doctorCourseContentPreview:
        final file = settings.arguments as FileData;
        return CustomPageRoute(
          page:FilePreview(fileData: file,),
        );

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
      case GPA:
        return MaterialPageRoute(builder: (context) => const Gpa_Calculator(),);
      default:
        return CustomPageRoute(page: const DoctorExamScreen());
    }
  }
}
