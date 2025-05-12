import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_platt/core/cashe/services/course_cashe_service.dart';
import 'package:edu_platt/core/cashe/services/notes_cache_service.dart';
import 'package:edu_platt/core/cashe/services/profile_cashe_service.dart';
import 'package:edu_platt/core/file_picker/file_picker_service.dart';
import 'package:edu_platt/presentation/Auth/service/token_service.dart';
import 'package:edu_platt/presentation/Doctor/features/home/presentation/widgets/doctor_drawer.dart';
import 'package:edu_platt/presentation/Doctor/screen/chat/ConversationDoctor/cubit/Dchat_cubit.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:edu_platt/presentation/profile/cubit/profile_cubit.dart';
import 'package:edu_platt/presentation/profile/data/profile_web_services.dart';
import 'package:edu_platt/presentation/profile/repository/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/Color/color.dart';

class Chatlistdoctor extends StatefulWidget {
  const Chatlistdoctor({super.key});

  @override
  State<Chatlistdoctor> createState() => _ChatlistdoctorState();
}

class _ChatlistdoctorState extends State<Chatlistdoctor> with SingleTickerProviderStateMixin{
  bool showStudentsChatDot = true;

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
                      onTap: () async{
                        setState(() {
                          showStudentsChatDot = false;
                        });

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
                                'Students Chat',
                                style: TextStyle(color: Colors.white, fontSize: 23.sp, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          if (showStudentsChatDot)
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
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
          setState(() {});
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
                  fontSize: 23.sp,
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
                width: 15.w,
                height: 20.h,
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
