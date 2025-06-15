import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:edu_platt/config/theme/theme.dart';
import 'package:edu_platt/core/cashe/services/course_cashe_service.dart';
import 'package:edu_platt/core/cashe/services/gpa_cashe_service.dart';
import 'package:edu_platt/core/cashe/services/notes_cache_service.dart';
import 'package:edu_platt/core/cashe/services/profile_cashe_service.dart';
import 'package:edu_platt/core/file_picker/file_picker_service.dart';
import 'package:edu_platt/fcm/fcm.dart';
import 'package:edu_platt/presentation/Auth/service/token_service.dart';

import 'package:edu_platt/presentation/Doctor/screen/chat/ConversationDoctor/cubit/Dchat_cubit.dart';
import 'package:edu_platt/presentation/Doctor/screen/chat/ConversationDoctor/repo/chat_Repo.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:edu_platt/presentation/Student/screen/GPA/cubit/gpa_cubit.dart';
import 'package:edu_platt/presentation/Student/screen/GPA/repo/repo.dart';
import 'package:edu_platt/presentation/Student/screen/Private_chat/Conversation/cubit/Chat_cubit.dart';
import 'package:edu_platt/presentation/Student/screen/Private_chat/Conversation/repo/chat_Repo.dart';
import 'package:edu_platt/presentation/Student/screen/notes/cubit/notes_cubit.dart';
import 'package:edu_platt/presentation/Student/screen/notes/data/notes_repository/notes_repository.dart';
import 'package:edu_platt/presentation/Student/screen/notes/data/notes_web_service/notes_web_service.dart';
import 'package:edu_platt/presentation/notification/presentation/cubit/notification_counter_cubit.dart';
import 'package:edu_platt/presentation/profile/cubit/profile_cubit.dart';
import 'package:edu_platt/presentation/profile/data/profile_web_services.dart';
import 'package:edu_platt/presentation/profile/repository/profile_repository.dart';
import 'package:edu_platt/services/local_notification_service.dart';
import 'package:edu_platt/services/push_notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


import 'firebase_options.dart';
import 'presentation/Doctor/features/course_details/domain/entities/course_details_entity.dart';


//final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
//final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 // await Fcm.init();
  WidgetsFlutterBinding.ensureInitialized();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  await deviceInfo.androidInfo; // Initialize the plugin
  await Hive.initFlutter();
  Hive.registerAdapter(CourseDetailsEntityAdapter());
  await Hive.deleteBoxFromDisk('Lectures');
  await Hive.deleteBoxFromDisk('Labs');
  await Hive.deleteBoxFromDisk('Exams');
  await Hive.deleteBoxFromDisk('Videos');
  await Hive.openBox<List<Map<String, List<CourseDetailsEntity>>>>('Lectures');
  await Hive.openBox<List<Map<String, List<CourseDetailsEntity>>>>('Labs');
  await Hive.openBox<List<Map<String, List<CourseDetailsEntity>>>>('Exams');
  await Hive.openBox<List<Map<String, List<CourseDetailsEntity>>>>('Videos');
  // await Future.wait([
  //   PushNotificationsService.init(),
  //   LocalNotificationService.init(),
  //
  // ]);
  try {
    await Future.wait([
      PushNotificationsService.initializePushNotifications(),
      LocalNotificationService.init(),
    ]);
  } catch (e) {
    log('Initialization error: $e');

  }
  runApp(MyApp(
  ));
}

class MyApp extends StatelessWidget {

   MyApp({super.key,
   });


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
                create: (context) => ProfileCubit(
                    profileRepository:
                    ProfileRepository(ProfileWebServices()),
                    tokenService: TokenService(),
                    filePickerService: FilePickerService(),
                    profileCacheService: ProfileCacheService(),
                    courseCacheService: CourseCacheService(),
                    notesCacheService: NotesCacheService()
                )
                  ..getProfileData(),
              ),
              BlocProvider(
                create: (_) => NotificationCounterCubit(),
              ),
              BlocProvider(
                create: (context) => GpaCubit(gpaRepository: GPARepository() , tokenService:TokenService() ,  gpaCacheService:GpaCasheServer() )..fetchGpa(),
              ),

              BlocProvider(create: (context) => DoctorChatCubit(DoctorChatRepository())),
              BlocProvider(create: (context) => ChatCubit(ChatRepository())),
              BlocProvider(
                create: (context) => NotesCubit(tokenService: TokenService(),
                    notesCacheService: NotesCacheService(),
                    notesRepository: NotesRepository(NotesWebService()))
                  ..getAllNotes(),
              )
    ],
           child:
        MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: AppTheme.theme,
                initialRoute: AppRouters.splashRoute,
                onGenerateRoute: AppRouters.generateRoute,
             ),
          //),
       )
    );
  }
}
