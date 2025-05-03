import 'package:device_info_plus/device_info_plus.dart';
import 'package:edu_platt/config/theme/theme.dart';
import 'package:edu_platt/core/cashe/services/notes_cache_service.dart';
import 'package:edu_platt/core/cashe/services/questions_cashe_service.dart';
import 'package:edu_platt/core/network/api_service.dart';
import 'package:edu_platt/core/network/internet_connection_service.dart';
import 'package:edu_platt/presentation/Auth/service/token_service.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/cubit/dialog_cubit.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/domain/entities/course_details_entity.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/repo/exam_repository_impl.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/bloc/exam_bloc.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:edu_platt/presentation/Student/screen/notes/cubit/notes_cubit.dart';
import 'package:edu_platt/presentation/Student/screen/notes/data/notes_repository/notes_repository.dart';
import 'package:edu_platt/presentation/Student/screen/notes/data/notes_web_service/notes_web_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  await deviceInfo.androidInfo; // Initialize the plugin
  await Hive.initFlutter();

  Hive.registerAdapter(CourseDetailsEntityAdapter());
  await Hive.deleteBoxFromDisk('Lectures');
  await Hive.deleteBoxFromDisk('Labs');
  await Hive.deleteBoxFromDisk('Exams');
  await Hive.openBox<List<Map<String, List<CourseDetailsEntity>>>>('Lectures');
  await Hive.openBox<List<Map<String, List<CourseDetailsEntity>>>>('Labs');
  await Hive.openBox<List<Map<String, List<CourseDetailsEntity>>>>('Exams');

  runApp(const MyApp());
}

///TODO:: NEED TO SET UP VIDEOS CACHE

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
          MultiBlocProvider(
            providers: [
              // BlocProvider(
              //   create: (context) => PDFExamBloc(),
              // ),
              BlocProvider(
                create: (context) => NotesCubit(tokenService: TokenService(),
                    notesCacheService: NotesCacheService(),
                    notesRepository: NotesRepository(NotesWebService()))
                  ..getAllNotes(),
              ),
              // BlocProvider<DialogCubit>(
              //   create: (context) => DialogCubit(),
              // ),
    //           BlocProvider(
    //           create: (context) => ExamBloc(
    //             dialogCubit: context.read<DialogCubit>(),
    //             doctorExamRepoImp:
    // DoctorExamRepoImp(
    // DoctorExamsRemoteDataSourceImpl(ApiService()),
    // NetworkInfoImpl(InternetConnectionChecker()),
    // ),
    // )..add(FetchExamsEvent(isExamtaken: false)),
    //           )
    ],
           child:
        MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: AppTheme.theme,
                initialRoute: AppRouters.splashRoute,
                onGenerateRoute: AppRouters.generateRoute
            ),
          ),
    );
  }
}
