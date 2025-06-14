import 'package:edu_platt/core/cashe/services/course_cashe_service.dart';
import 'package:edu_platt/core/cashe/services/notes_cache_service.dart';
import 'package:edu_platt/core/utils/Assets/appAssets.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Doctor/features/home/presentation/widgets/container_drawer.dart';
import 'package:edu_platt/presentation/notification/presentation/cubit/notification_counter_cubit.dart';
import 'package:edu_platt/services/push_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/cashe/services/profile_cashe_service.dart';
import '../../../../../core/file_picker/file_picker_service.dart';
import '../../../../Auth/service/token_service.dart';


import '../../../../Routes/custom_AppRoutes.dart';
import '../../../../profile/cubit/profile_cubit.dart';
import '../../../../profile/data/profile_web_services.dart';
import '../../../../profile/repository/profile_repository.dart';

class Drawerr extends StatefulWidget {
  const Drawerr({super.key});

  @override
  State<Drawerr> createState() => _DrawerrState();
}

class _DrawerrState extends State<Drawerr> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late List<Animation<double>> _fadeAnimations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0.3, 0)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _fadeAnimations = List.generate(6, (index) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
            curve: Interval(
              index * (1.0 / 6),
              (index + 1) * (1.0 / 6),
              curve: Curves.easeInOut,
            )
        ),
      );
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: const Color(0xffE6E6E6),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(
            width: double.infinity,
            height: 170.h,
            decoration: BoxDecoration(
              color: color.primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(
                image: const AssetImage(AppAssets.IC_drawer), //
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.3), //
                  BlendMode.dstATop, //
                ),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Center(
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 25.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: REdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 13.h,
                      ),
                      Text(
                        "Student Services!",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Colors.white,
                              fontSize: 17.sp,
                            ),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          // FadeTransition(
          //     opacity: _fadeAnimations[0],
          //     child: ContainerDrawer(
          //       icons: Icons.home,
          //       text: "Home",
          //       onTap: () {
          //         Navigator.pushNamed(context, AppRouters.HomeStudent);
          //             // NavigationHelper.navigateWithAnimation(
          //         //     context, const HomeStudentScreen());
          //        // Navigator.pop(context);  // no need to push new screen
          //       },
          //     )),
              FadeTransition(
                opacity: _fadeAnimations[0],
                child: ContainerDrawer(
                    icons: Icons.golf_course,
                    text: "Register Courses",
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, AppRouters.studentSemesterRoute);
                    }),
              ),          FadeTransition(
            opacity: _fadeAnimations[1],
            child: ContainerDrawer(
                icons: Icons.golf_course, text: "Lecture Schedule", onTap: () {
              Navigator.pushNamed(context, AppRouters.pdfFileScreen , arguments: 'LectureSchedule');

            }),
          ),
          FadeTransition(
            opacity: _fadeAnimations[2],
            child: ContainerDrawer(
                icons: Icons.schema, text: "Labs Schedule", onTap: () {
              Navigator.pushNamed(context, AppRouters.pdfFileScreen , arguments: 'LabSchedule');

            }),
          ),
          FadeTransition(
              opacity: _fadeAnimations[3],
              child: ContainerDrawer(
                  icons: Icons.schedule, text: "Exam Schedule", onTap: () {
                Navigator.pushNamed(context, AppRouters.pdfFileScreen , arguments: 'ExamSchedule');

              })),
          FadeTransition(
            opacity: _fadeAnimations[4],
            child: ContainerDrawer(
                icons: Icons.integration_instructions_outlined,
                text: "Student Guide",
                onTap: () {

                  Navigator.pushNamed(context, AppRouters.pdfFileScreen , arguments: 'StudentGuide');

                }),
          ),
              FadeTransition(
                opacity: _fadeAnimations[5],
                child: ContainerDrawer(
                    icons: Icons.integration_instructions_outlined,
                    text: "GPA Calculator",
                    onTap: () {
                      Navigator.pushNamed(context, AppRouters.GPA);
                    }),
              ),
              BlocProvider(
                create: (context) => ProfileCubit(
                    profileRepository: ProfileRepository(ProfileWebServices()),
                    tokenService: TokenService(),
                    filePickerService: FilePickerService(),
                    profileCacheService: ProfileCacheService(),
                   notesCacheService: NotesCacheService(),
                  courseCacheService: CourseCacheService(),
                ),
                child: BlocListener<ProfileCubit, ProfileState>(
  listener: (context, state) {
     if(state is LogOutSuccess){
       PushNotificationsService.onNewNotification = () {
         context.read<NotificationCounterCubit>().reset();
       };
         Navigator.pushNamedAndRemoveUntil(
           context,
           AppRouters.studentOrDoctor,
               (route) => false,
         );
     }
     if(state is LogoutError){
       ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
             content: Text(state.errorMessage)),
       );
     }
  },
  child: BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    return FadeTransition(
                        opacity: _fadeAnimations[5],
                        child: ContainerDrawer(
                            icons: Icons.logout,
                            text: "Logout",
                            onTap: () {
                              context.read<ProfileCubit>().clearUponUserType();
                              context.read<ProfileCubit>().logout();

                            }));
                  },
                ),
),
              ),
        ]));
  }
}
