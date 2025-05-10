
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_platt/core/utils/Assets/appAssets.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:edu_platt/presentation/Routes/custom_pageRoute.dart';
import 'package:edu_platt/presentation/Student/screen/exam/presentation/exam_tab.dart';
import 'package:edu_platt/presentation/Student/screen/home/presentation/drawer.dart';
import 'package:edu_platt/presentation/Student/screen/chat/Chat_List.dart';
import 'package:edu_platt/presentation/Student/screen/levels/levels.dart';
import 'package:edu_platt/presentation/notification/presentation/cubit/notification_counter_cubit.dart';
import 'package:edu_platt/presentation/notification/presentation/views/notification_view.dart';
import 'package:edu_platt/presentation/profile/profile.dart';
import 'package:edu_platt/services/local_notification_service.dart';
import 'package:edu_platt/services/push_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../notes/presentation/nots.dart';
class HomeStudentScreen extends StatefulWidget {
  const HomeStudentScreen({super.key});

  @override
  State<HomeStudentScreen> createState() => _HomeStudentState();
}

class _HomeStudentState extends State<HomeStudentScreen>
    with SingleTickerProviderStateMixin {
  List<Widget> tabs = [
    Levels(),
     Notes(),
    ChatList(),
    StudentExamTab(),
     Profile()
  ];
  int selectedIndex = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    //listenToNotificationStream();
    PushNotificationsService.onNewNotification = () {
      context.read<NotificationCounterCubit>().increment();
    };
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  // void listenToNotificationStream() {
  //   LocalNotificationService.streamController.stream.listen((event) {
  //     Navigator.pushNamed(context, AppRouters.notificationCenterScreen);
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Return true to allow exiting the app
        return true;
      },
      child: Scaffold(
        drawer: const Drawerr(),
        appBar:  AppBar(
        elevation: 0,
        backgroundColor: (selectedIndex == 4 || selectedIndex == 3||selectedIndex == 2)
            ? color.primaryColor
            : (selectedIndex == 1 ? color.primaryColor : Colors.transparent),
        scrolledUnderElevation: 0,
        toolbarHeight: (selectedIndex == 4 || selectedIndex == 3||selectedIndex == 2)
            ? 60.h
            : (selectedIndex == 1 ? 80.h : 130.h),
        shape: selectedIndex == 1
            ? null
            : RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.r),
            bottomRight: Radius.circular(30.r),
          ),
        ),
        title: (selectedIndex == 4 || selectedIndex == 3||selectedIndex == 2)
            ? Text(
          selectedIndex == 2 ? "Chat" : (selectedIndex == 4 ? "Profile" : "Exams"),          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontSize: 22.sp,
            fontWeight: FontWeight.w500,
          ),
        )
            : (selectedIndex == 1
            ? Text(
          "Notes",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontSize: 22.sp,
            fontWeight: FontWeight.w500,
          ),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30.h),
            ScaleTransition(
              scale: _animation,
              child: Image.asset(
                AppAssets.logo,
              ),
            ),
          ],
        )),
        centerTitle: true,
          actions: [
            BlocBuilder<NotificationCounterCubit, int>(
              builder: (context, count) {
                return Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.notifications,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                         CustomPageRoute(page:  const NotificationCenterScreen()),
                        );
                      },
                    ),
                    if (count > 0)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.red,
                          child: Text(
                            '$count',
                            style: const TextStyle(fontSize: 10, color: Colors.white),
                          ),
                        ),
                      )
                  ],
                );
              },
            ),
          ],
      ),

      body: tabs[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            _buildBottomNavigationBarItem(Icons.golf_course, "Levels", 0),
            _buildBottomNavigationBarItem(Icons.note_alt_sharp, "Notes", 1),
            _buildBottomNavigationBarItem(Icons.chat, "Chat", 2),
            _buildBottomNavigationBarItem(Icons.grading_sharp, "Exams", 3),
            _buildBottomNavigationBarItem(Icons.person, "Profile", 4),
          ],
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: selectedIndex == index
          ? Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.primaryColor.withOpacity(1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
            )
          : Icon(icon, color: Colors.grey),
      label: label,
    );
  }
}
