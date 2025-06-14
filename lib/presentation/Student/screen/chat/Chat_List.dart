import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_platt/core/cashe/services/course_cashe_service.dart';
import 'package:edu_platt/core/cashe/services/notes_cache_service.dart';
import 'package:edu_platt/core/cashe/services/profile_cashe_service.dart';
import 'package:edu_platt/core/file_picker/file_picker_service.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Auth/service/token_service.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:edu_platt/presentation/Student/screen/Private_chat/Conversation/cubit/Chat_cubit.dart';
import 'package:edu_platt/presentation/profile/cubit/profile_cubit.dart';
import 'package:edu_platt/presentation/profile/data/profile_web_services.dart';
import 'package:edu_platt/presentation/profile/repository/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatList extends StatefulWidget {


  ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> with SingleTickerProviderStateMixin{



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
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
      child: Scaffold(
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
                      child: BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, state) {
                          if (state is! ProfileLoaded) {
                            return Center(child: CircularProgressIndicator());
                          }
                          final user = state.userModel;
                          final currentUserEmail = user.email ?? '';

                          return StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('messages')
                                .orderBy('createdAt', descending: true)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return _buildCommunityChatTile();
                              }

                              return FutureBuilder<DateTime?>(
                                future: getLastOpenedCommunityChatTime(),
                                builder: (context, timeSnapshot) {
                                  if (!timeSnapshot.hasData) {
                                    return _buildCommunityChatTile();
                                  }

                                  final lastOpened = timeSnapshot.data!;
                                  final newMessages = snapshot.data!.docs.where((doc) {
                                    final createdAt = (doc['createdAt'] as Timestamp).toDate();
                                    final senderId = doc['id'] as String?;

                                    print("📩 Message from: $senderId | Current user: $currentUserEmail | Created at: $createdAt");

                                    return createdAt.isAfter(lastOpened) && senderId != currentUserEmail;
                                  }).length;


                                  return _buildCommunityChatTile(unreadCount: newMessages);
                                },
                              );
                            },
                          );
                        },
                      ),

                    ),

                    SizedBox(width: 16.w),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            // showDoctorsChatDot = false;
                          });

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
                        child: Stack(
                          children: [
                            Container(
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
                                  style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            // if (showDoctorsChatDot)
                            //   Positioned(
                            //     top: 10,
                            //     right: 10,
                            //     child: Container(
                            //       width: 15,
                            //       height: 15,
                            //       decoration: BoxDecoration(
                            //         color: Colors.red,
                            //         shape: BoxShape.circle,
                            //       ),
                            //     ),
                            //   ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),

      ),
    );
  }
  Widget _buildCommunityChatTile({int unreadCount = 0}) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRouters.GeneralChatScreen).then((_) {
          setState(() {}); // إعادة بناء الشاشة لتحديث عدد الرسائل
        });
      },
      child: Stack(
        children: [
          Container(
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
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (unreadCount > 0)
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                width: 15,
                height: 15,
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }

}
Future<DateTime?> getLastOpenedCommunityChatTime() async {
  final prefs = await SharedPreferences.getInstance();
  int? millis = prefs.getInt('lastOpenedCommunityChat');
  if (millis != null) {
    return DateTime.fromMillisecondsSinceEpoch(millis);
  }
  return null;
}
