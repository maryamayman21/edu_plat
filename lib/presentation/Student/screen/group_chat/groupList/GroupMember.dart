// screens/group_chat_screen.dart

import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Auth/service/token_service.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:edu_platt/presentation/Student/screen/group_chat/cubit/Group_Cubit.dart';
import 'package:edu_platt/presentation/Student/screen/group_chat/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class GroupMember extends StatelessWidget {
  final String courseCode;


  const GroupMember({
    super.key,
    required this.courseCode,

  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GroupChatCubit(TokenService())..fetchGroupChat(courseCode),
      child: Scaffold(
        backgroundColor: color.primaryColor,
        appBar: AppBar(
          title: Text('Members',style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          )),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),          backgroundColor: color.primaryColor,
        ),
        body:Container(
          color: Colors.grey[200],
          child: BlocBuilder<GroupChatCubit, GroupChatState>(
            builder: (context, state) {
              if (state is GroupChatLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GroupChatLoaded) {
                final doctors = state.groupChat.doctors;
                final students = state.groupChat.students;

                return Column(
                  children: [
                    Expanded(
                      child: ListView(
                        padding: REdgeInsets.all(15),
                        children: [
                          Text('Doctor',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 23.sp,
                                color: color.primaryColor,
                              )),
                          const SizedBox(height: 10),
                          ...doctors.map((d) => Padding(
                            padding: REdgeInsets.only(bottom: 10),
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                contentPadding: REdgeInsets.all(12),
                                leading: CircleAvatar(
                                  radius: 30.r,
                                  backgroundColor: Colors.grey[300],
                                  child: Icon(Icons.person, size: 30, color: Colors.white),
                                ),
                                title: Text(
                                  d.name,
                                  style: TextStyle(
                                    color: color.secondColor,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )),
                          const SizedBox(height: 20),
                          Text('Students',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 23.sp,
                                color: color.primaryColor,
                              )),
                          const SizedBox(height: 10),
                          ...students.map((s) => Padding(
                            padding: REdgeInsets.only(bottom: 10),
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                contentPadding: REdgeInsets.all(12),
                                leading: CircleAvatar(
                                  radius: 30.r,
                                  backgroundColor: Colors.grey[300],
                                  child: Icon(Icons.person_outline, size: 30, color: Colors.white),
                                ),
                                title: Text(
                                  s.name,
                                  style: TextStyle(
                                    color: color.secondColor,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: REdgeInsets.all(10),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                           Navigator.pushReplacementNamed(context, AppRouters.chatGroup, arguments: courseCode,);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: color.primaryColor,
                            padding: EdgeInsets.symmetric(vertical: 15.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            "Start Chat",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is GroupChatError) {
                return Center(child: Text('❌ ${state.message}'));
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}