
import 'package:edu_platt/presentation/Doctor/features/login/presentation/login_view.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/exam_model.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/bloc/pdf_exam_bloc.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/views/exam_dashboard_screen.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/views/exam_tab.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/views/exams_view.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/views/make_online_exam.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/views/offline_exam_view.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/views/pdf_creation_written_exam.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/views/pdf_mcq_form_exam.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/views/pdf_mcq_questions_exam.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/views/pdf_written_exam.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/views/update_offline_exam.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/views/update_online_exam.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/views/view_student_degrees_view.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/doctor_courses.dart';
import 'package:edu_platt/presentation/Student/screen/GPA/C_Gpa.dart';
import 'package:edu_platt/presentation/Student/screen/StudentCourseRegister/RegisterCourse/StudentCourseRegisteration.dart';
import 'package:edu_platt/presentation/Student/screen/StudentCourseRegister/RegisterCourse/StudentcourseRegisteredScuccess.dart';
import 'package:edu_platt/presentation/Student/screen/StudentCourseRegister/StudentSemesterScreen/StudentSemesterScreen.dart';
import 'package:edu_platt/presentation/Student/screen/exam/presentation/exam_tab.dart';
import 'package:edu_platt/presentation/Student/screen/exam/presentation/exams_screen.dart';
import 'package:edu_platt/presentation/Student/screen/exam/presentation/quiz_screen.dart';
import 'package:edu_platt/presentation/Student/screen/exam/presentation/widgets/quiz_result_screen.dart';
import 'package:edu_platt/presentation/Student/screen/home/homeStudent.dart';
import 'package:edu_platt/presentation/Student/screen/levels/presentation/StudentviewAllCourses.dart';
import 'package:edu_platt/presentation/sharedWidget/image_viewer/image_viewer_screen.dart';
import 'package:edu_platt/presentation/sharedWidget/pdf_viwer/pdf_viwer_screen.dart';
import 'package:edu_platt/presentation/sharedWidget/video_viewer/video_viewer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import '../Student/screen/CourseDetails/courseDetails.dart';
import '../Student/screen/exam/presentation/examDetails.dart';
import '../Student/screen/exam/presentation/start_exam_screen.dart';
// import '../Student/screen/levels/levelsDetails/level1/level1.dart';
// import '../Student/screen/levels/levelsDetails/level2/level2.dart';
// import '../Student/screen/levels/levelsDetails/level3/level3.dart';
// import '../Student/screen/levels/levelsDetails/level4/level4.dart';
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
  static const String startExamScreen = '/ExamScreen';
  static const String ExamDetails = '/ExamDetails';
  static const String doctorProfileRoute = '/doctorProfileRoute';
 // static const String doctorChatRoute = '/doctorChatRoute';
  static const String doctorHomeRoute = '/doctorHomeRoute';
  static const String studentCourseRegisterationRoute = '/studentCourseRegisterRoute';
  static const String doctorCourseRegisterationRoute = '/doctorCourseRegisterRoute';
  static const String doctorViewAllCoursesRoute = '/doctorViewAllCoursesRoute';
  static const String doctorSemesterRoute = '/doctorSemesterRoute';
  static const String doctorCoursesRegisterSuccessRoute = '/doctorCourseRegisterSuccessRoute';
  static const String doctorCourseDetailsRoute = '/doctorCourseDetailsRoute';
  static const String doctorCourseContentPreview ='/doctorCourseContentPreview';
  static const String doctorLogin ='/doctorLogin';
  static const String studentCourseDetails = '/studentCourseDetails';
  static const String changePasswordRoute = '/changePasswordRoute';
  static const String changePasswordSuccRoute = '/changePasswordSuccRoute';
  static const String doctorMakeAnOnlineExamRoute = '/makeAnOnlineExamRoute';
  static const String StartExam = '/startExamRoute';
  static const String GPA = '/GPA';
  static const String studentCoursesRegisterSuccessRoute = '/studentCoursesRegisterSuccessRoute';
  static const String studentSemesterRoute = '/studentSemesterRoute';
  static const String studentViewAllCoursesRoute="/studentViewAllCoursesRoute";
 // static const String studentCourseDetailsRoute="/studentCourseDetailsRoute";
  static const String doctorCoursesScreen = '/doctorCoursesRoute';
  static const String pdfViewerScreen = '/pdfViewerRoute';
  static const String imageViewerScreen = '/imageViewerRoute';
  static const String videoViewerScreen = '/videoViewerRoute';
  static const String doctorExamsViews = '/doctorExamsViewsRoute';
  static const String doctorExamDashboard = '/doctorExamDashboardRoute';
  static const String doctorOnlineExamEditScreen= '/doctorOnlineExamEditRoute';
  static const String doctorOfflineExamEditScreen= '/doctorOfflineExamEditRoute';
  static const String doctorOfflineExamScreen= '/doctorOfflineExamRoute';
  static const String doctorStudentDegreesScreen= '/doctorStudentDegreesRoute';

  static const String studentExamTabScreen= '/StudentExamRoute';
  static const String studentExamsScreen= '/StudentExamsRoute';
  static const String studentQuizScreen= '/StudentQuizRoute';
  static const String studentQuizResultScreen= '/StudentQuizResultRoute';
  static const String writtenPdfCreationScreen= '/pdfCreationRoute';
  static const String pdfWrittenQuestionScreen= '/PdfWrittenQuestionScreenRoute';
  static const String pdfSetQuestionScreen= '/PdfSetQuestionScreenRoute';
  static const String pdfSetFormDateExamScreen= '/PdfSetFormDataExamScreenRoute';

  static Route? generateRoute(RouteSettings settings) {
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
      case doctorMakeAnOnlineExamRoute:
        return MaterialPageRoute(builder: (context) => const MakeOnlineExam(),);

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
        return CustomPageRoute(page: const SemesterScreen());
      case studentSemesterRoute:
        return CustomPageRoute(page: const StudentSemesterscreen());
        return CustomPageRoute(page: const SemesterScreen());
      // case doctorCourseDetailsRoute:
      //   final courseCode = settings.arguments as String? ?? "default_code";
      //   return CustomPageRoute(
      //     page: CourseDetails(courseCode: courseCode),
      //   );
      // case studentCourseDetailsRoute:
      //   final courseCode = settings.arguments as String? ?? "default_code";
      //   return CustomPageRoute(
      //     page: StudentCourseDetails(courseCode: courseCode),
      //   );
      case doctorCourseContentPreview:
        final file = settings.arguments as FileData;
        return CustomPageRoute(
          page:FilePreview(fileData: file,),
        );

      case verifyEmail :
        final userDate = settings.arguments as List<String>;
        return CustomPageRoute(page:VerifyEmail( arguemnt: userDate,));
      case studentCourseDetails :
        final args = settings.arguments as Map<String, dynamic>; // Cast arguments to Map
        final courseDetail = args['courseCode'] as Map<String, dynamic>; // Extract courseDetail
        final doctorId = args['doctorId'] as String; // Extract doctorId

        return CustomPageRoute(page: Coursedetails(courseDetails:courseDetail , doctorId: doctorId,));//tmam
      case startExamScreen:
        return CustomPageRoute(page: const StartExamScreen());
      case ExamDetails:
        return MaterialPageRoute(
            builder: (context) => const Examdetails());
      case HomeStudent:
        return MaterialPageRoute(
            builder: (context) => const HomeStudentScreen());
      case changePasswordRoute:
        return CustomPageRoute(page: const Changepassword());
        case doctorCoursesScreen:
          final courseDetail = settings.arguments as Map<String,dynamic>;
        return CustomPageRoute(page: DoctorCoursesScreen(courseDetail:courseDetail,)); //tmam
      case changePasswordSuccRoute:
        return MaterialPageRoute(
            builder: (context) => const ChangePasswordSuccess());
      case GPA:
        return MaterialPageRoute(builder: (context) => const Gpa_Calculator(),);
      case doctorLogin:
        return MaterialPageRoute(
            builder: (context) => const LoginScreen());
      case pdfViewerScreen :
        final args = settings.arguments as Map<String, dynamic>; // Cast arguments to Map
        final pdfUrl =args['pdfUrl'] as String;
        final pdfName = args['pdfName'] as String;
        return CustomPageRoute(page:PdfViewerScreen(pdfUrl: pdfUrl, pdfName: pdfName));
      case imageViewerScreen:
        final args = settings.arguments as Map<String, dynamic>; // Cast arguments to Map
        final imageUrl =args['imageUrl'] as String;
        final imageName = args['imageName'] as String;
        return CustomPageRoute(page:ImageViewerScreen(imageName: imageName, imageUrl: imageUrl,));
      case videoViewerScreen:
        final args = settings.arguments as Map<String, dynamic>; // Cast arguments to Map
        final videoUrl =args['videoUrl'] as String;
        final videoName = args['videoName'] as String;
         return CustomPageRoute(page:NetworkVideoPlayerScreen(videoUrl: videoUrl,videoName: videoName, ));
    case doctorExamsViews:
      final isTakenExam = settings.arguments as bool;
       return CustomPageRoute(page: ExamsView(isTaken: isTakenExam));
       case doctorExamDashboard:
       return MaterialPageRoute(
       builder: (context) => DashboardScreen());
      case doctorOnlineExamEditScreen:
        final examId = settings.arguments as int;
       return MaterialPageRoute(
       builder: (context) => UpdateOnlineExam(examId: examId,));
      case doctorOfflineExamScreen:
        return CustomPageRoute(page:OfflineExamView()); //
      case doctorOfflineExamEditScreen:
       final examId = settings.arguments as int;
        return CustomPageRoute(page:UpdateOfflineExamView(examId: examId,));
          case doctorStudentDegreesScreen:
       final examId = settings.arguments as int;
        return CustomPageRoute(page:ViewStudentDegreesView(
          examId:examId ,
        ));
        case studentExamsScreen:
       final isTaken = settings.arguments as bool;
        return CustomPageRoute(page:ExamsScreen(isTaken: isTaken,));
      case pdfSetQuestionScreen:
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        final isWrittenExam = args['isWrittenExam'] as bool;
        final pdfExamBloc = args['bloc'] as PDFExamBloc;
        return CustomPageRoute(
          page: BlocProvider.value(
            value: pdfExamBloc,
            child: PdfExamQuestions(isWrittenExam: isWrittenExam),
          ),
        );
       case pdfSetFormDateExamScreen:
         final isWrittenExam = settings.arguments as bool;
        return CustomPageRoute(page: PdfMcqFormExam(
          isWrittenExam: isWrittenExam,
        ));
      case studentExamTabScreen:
        return MaterialPageRoute(
            builder: (context) => StudentExamTab());
  case pdfWrittenQuestionScreen:
        return MaterialPageRoute(
            builder: (context) => const PdfWrittenQuestionScreen());
 // case studentQuizScreen:
 //        return MaterialPageRoute(
 //            builder: (context) => const QuizScreen());
 //
        case writtenPdfCreationScreen:
          final args = settings.arguments as Map<String, dynamic>;
          final writtenExamModel = args['examModel'] as PDFExamModel;
          final isWrittenExam = args['isWrittenExam'] as bool;
          return MaterialPageRoute(
            builder: (context) =>   WrittenPdfCreatorScreen(
              isWrittenExam: isWrittenExam,
              examModel:writtenExamModel ,
            ));
case studentQuizResultScreen:
  final args = settings.arguments as Map<String, dynamic>;
  final String courseCode = args['courseCode'] as String;
  final String quizTitle = args['quizTitle'] as String;
  final int totalMark = args['totalMark'] as int;
  final int earnedScore = args['earnedScore'] as int;
  final int correctAnswers = args['correctAnswers'] as int;
        return MaterialPageRoute(
            builder: (context) => QuizResultScreen(
              courseCode: courseCode,
              correctAnswers: correctAnswers,
              earnedScore: earnedScore,
              quizTitle:quizTitle ,
              totalScore: totalMark,
            ));

      default:
        return null;

    }
  }
}
