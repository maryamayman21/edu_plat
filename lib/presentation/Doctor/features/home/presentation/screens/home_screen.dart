import 'package:edu_platt/presentation/Doctor/features/courses/presentation/screens/courses_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/Color/color.dart';

import '../../../../../profile/profile.dart';
import '../../../../screen/chat/chat.dart';
import '../../../../screen/exam/exam.dart';
import '../../../profile/profile.dart';
import '../../application/navigation_cubit.dart';
import '../widgets/doctor_drawer.dart';
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin  {
 final List<Widget> tabs = [
   const CoursesScreen(),
    const DoctorChatScreen(),
   const DoctorExamScreen(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider<AppBarCubit>(
        //   create: (context) => AppBarCubit()..initAnimation(this),
        // ),
        BlocProvider<NavigationCubit>(
          create: (_) => NavigationCubit(),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
           //drawer: const DoctorDrawer(),
          body: BlocBuilder<NavigationCubit, int>(
            builder: (context, state) {
              return tabs[state]; // Show the screen based on the selected tab.
            },
          ),
          bottomNavigationBar: BlocBuilder<NavigationCubit, int>(
            builder: (context, state) {
              return BottomNavigationBar(
                backgroundColor: Colors.white,
                currentIndex: state,
                onTap: (index) {
                  context.read<NavigationCubit>().changeTab(index);
                },
                items:  [
                  _buildBottomNavigationBarItem(Icons.home_filled, "Courses", 0, state),
                  _buildBottomNavigationBarItem(Icons.grading_sharp, "Exam", 1, state),
                  _buildBottomNavigationBarItem(Icons.chat, "Chat", 2, state),
                  _buildBottomNavigationBarItem(Icons.person, "Profile", 3, state),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

 BottomNavigationBarItem _buildBottomNavigationBarItem(IconData icon,
     String label, int index,int currentState) {
   return BottomNavigationBarItem(
     icon: currentState == index
         ? Container(
       width: 40,
       height: 40,
       decoration: const BoxDecoration(
         color: color.primaryColor,
         shape: BoxShape.circle,
       ),
       child: Icon(
         icon,
         color: Colors.white,
       ),
     )
         : Icon(icon, color: Colors.grey),
     label: label,

   );
 }
}
