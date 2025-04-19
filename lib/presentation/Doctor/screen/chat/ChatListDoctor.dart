import 'package:edu_platt/presentation/Auth/service/token_service.dart';
import 'package:edu_platt/presentation/Doctor/features/home/presentation/widgets/doctor_drawer.dart';
import 'package:edu_platt/presentation/Doctor/screen/chat/ConversationDoctor/cubit/Dchat_cubit.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/Color/color.dart';

class Chatlistdoctor extends StatefulWidget {
  const Chatlistdoctor({super.key});

  @override
  State<Chatlistdoctor> createState() => _ChatlistdoctorState();
}

class _ChatlistdoctorState extends State<Chatlistdoctor> with SingleTickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DoctorDrawer(),
      appBar: AppBar(
        elevation: 0,
          backgroundColor:color.primaryColor,
        scrolledUnderElevation: 0,
          toolbarHeight:80.h,
          shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.r),
              bottomRight: Radius.circular(30.r),
            ),
          ),
          title: Text(
            "Chat",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        centerTitle: true,
        actions: [
          Padding(
            padding: REdgeInsets.only(right: 10),
            child: Icon(
              Icons.notifications_active,
              color: Colors.grey,
              size: 30.r,
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white,Color(0xFFBEC6D3) ],
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Center(
          child: Padding(
            padding: REdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRouters.GeneralChatScreen);
                    },
                    child: Container(
                      height: 250.h,
                      decoration: BoxDecoration(
                        color: color.primaryColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 15,
                            offset: Offset(10, 10),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Community Chat',
                          style: TextStyle(color: Colors.white, fontSize: 23.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ).animate().scale(duration: 500.ms, curve: Curves.easeInOut),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: GestureDetector(
                    onTap: () async{
                      String? token = await TokenService().getToken();
                      print("Token: $token");
                      if (token == null || token.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Authentication token not found!"))
                        );
                        return;
                      }
                      context.read<DoctorChatCubit>().fetchStudents(token);
                      Navigator.pushNamed(context, AppRouters.ConversationDoctorChat);
                    },
                    child: Container(
                      height: 250.h,
                      decoration: BoxDecoration(
                        color: color.secondColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 15,
                            offset: Offset(10, 10),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Students Chat',
                          style: TextStyle(color: Colors.white, fontSize: 23.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ).animate().scale(duration: 500.ms, curve: Curves.easeInOut),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
