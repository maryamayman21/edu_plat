import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_platt/core/cashe/services/course_cashe_service.dart';
import 'package:edu_platt/core/cashe/services/notes_cache_service.dart';
import 'package:edu_platt/core/cashe/services/profile_cashe_service.dart';
import 'package:edu_platt/core/file_picker/file_picker_service.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Auth/service/token_service.dart';
import 'package:edu_platt/presentation/Doctor/screen/chat/ConversationDoctor/StudentModel/model.dart';
import 'package:edu_platt/presentation/Doctor/screen/chat/ConversationDoctor/cubit/Dchat_cubit.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:edu_platt/presentation/Student/screen/Private_chat/Conversation/conviration_wedgit.dart';
import 'package:edu_platt/presentation/profile/cubit/profile_cubit.dart';
import 'package:edu_platt/presentation/profile/repository/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../profile/data/profile_web_services.dart';



class ConvirationDoctorWedgit extends StatefulWidget {
  const ConvirationDoctorWedgit({super.key});

  @override
  State<ConvirationDoctorWedgit> createState() => _ConvirationDoctorWedgitState();
}

class _ConvirationDoctorWedgitState extends State<ConvirationDoctorWedgit> {
  Map<String, int> unreadMessagesCount = {};
  DateTime? lastOpened;

  @override
  void initState() {
    super.initState();
    _setupUnreadMessagesListener();
  }

  void _setupUnreadMessagesListener() {
    final profileState = context.read<ProfileCubit>().state;
    final currentUserEmail = profileState is ProfileLoaded ? profileState.userModel.email : "";

    if (currentUserEmail.isEmpty) return;

    FirebaseFirestore.instance
        .collectionGroup('messages')
        .where('receiverId', isEqualTo: currentUserEmail)
        .where('isRead', isEqualTo: false)
        .snapshots()
        .listen((snapshot) {
      // تحديث العداد عند استلام رسائل جديدة
      _updateUnreadCounts();
    });
  }

  void _updateUnreadCounts() async {
    // إعادة حساب جميع الرسائل غير المقروءة
    // ... تنفيذ منطق حساب الرسائل غير المقروءة لكل محادثة
    setState(() {});
  }
  Future<void> getUnreadCount(String studentEmail, String doctorEmail) async {
    final roomId = "${studentEmail}_$doctorEmail";
    final prefs = await SharedPreferences.getInstance();
    final lastOpenedMillis = prefs.getInt('lastOpenedPrivate') ?? 0;
    final lastOpened = DateTime.fromMillisecondsSinceEpoch(lastOpenedMillis);

    final snapshot = await FirebaseFirestore.instance
        .collection('chats')
        .doc(roomId)
        .collection('messages')
        .where('receiverId', isEqualTo: doctorEmail) // للطبيب
        .where('createdAt', isGreaterThan: Timestamp.fromDate(lastOpened))
        .where('isRead', isEqualTo: false)
        .get();

    setState(() {
      unreadMessagesCount[roomId] = snapshot.docs.length;
    });
  }



  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
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
          backgroundColor: color.primaryColor,
          appBar: AppBar(
            title: const Text("Conversation" ,style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
            backgroundColor: color.primaryColor,
          ),
          body: Container(
            color: Colors.grey[200],
            child: BlocBuilder<DoctorChatCubit, DoctorChatState>(
              builder: (context, state) {
                if (state is ChatLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ChatLoaded) {
                  return ListView.builder(
                    itemCount: state.students.length,
                    itemBuilder: (context, index) {
                      final StudentModel  student = state.students[index] as StudentModel;
                      final profileState = context.read<ProfileCubit>().state;
                      String doctorEmail = "";
                      if (profileState is ProfileLoaded) {
                        doctorEmail = profileState.userModel.email ?? "";
                      }
                      getUnreadCount(student.email!, doctorEmail);

                      return Padding(
                        padding: REdgeInsets.all(8.0),
                        child: Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(12),
                                    leading: Stack(
                                      children: [
                                        CircleAvatar(
                                          radius: 40,
                                          backgroundColor: Colors.grey[300],
                                          backgroundImage: student.imageBytes != null
                                              ? MemoryImage(student.imageBytes!)
                                              : null,
                                          child: student.imageBytes == null
                                              ? Icon(Icons.person, color: Colors.white, size: 40)
                                              : null,
                                        ),

                                      ],
                                    ),

                                    title: Text(
                                      student.name,
                                      style: TextStyle(
                                        color: color.secondColor,
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    trailing: Icon(Icons.chat, color: Colors.grey),
                                    onTap: () {
                                      if (student.id != null && student.name != null && student.email != null) {
                                        Navigator.pushNamed(
                                          context,
                                          AppRouters.DoctorprivateChat,
                                          arguments: {
                                            "studentName": student.name!,
                                            "studentEmail": student.email!,
                                          },
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text("Student data is incomplete!")),
                                        );
                                      }
                                        },
                                      )
                                  ),

                      );
                    },
                  );
                } else {
                  return Center(child: Text("No students found"));
                }
              },
            ),
          ),
        ),

    );
  }
}

