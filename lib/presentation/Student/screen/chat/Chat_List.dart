import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Auth/service/token_service.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:edu_platt/presentation/Student/screen/Private_chat/Conversation/cubit/Chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatList extends StatefulWidget {


  ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> with SingleTickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        context.read<ChatCubit>().fetchDoctors(token);
                        Navigator.pushNamed(context, AppRouters.ConversationStudentChat);
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
                            'Doctors Chat',
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
