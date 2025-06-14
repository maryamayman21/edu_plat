import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:edu_platt/core/cashe/services/course_cashe_service.dart';
import 'package:edu_platt/core/cashe/services/notes_cache_service.dart';
import 'package:edu_platt/core/cashe/services/profile_cashe_service.dart';
import 'package:edu_platt/core/file_picker/file_picker_service.dart';
import 'package:edu_platt/core/utils/Assets/appAssets.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Student/screen/chat/data/chat_Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Auth/service/token_service.dart';
import '../../../profile/cubit/profile_cubit.dart';
import '../../../profile/data/profile_web_services.dart';
import '../../../profile/model/user.dart';
import 'package:intl/intl.dart';
import '../../../profile/repository/profile_repository.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}
class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _saveLastOpenedTime();
  }

  void _saveLastOpenedTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastOpenedCommunityChat', DateTime.now().millisecondsSinceEpoch);
  }
  @override
  void dispose() {
    _textController.dispose();

    _saveLastOpenedTime(); // حفظ آخر وقت عند الخروج من الشاشة
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
      final ScrollController _controller = ScrollController();
      CollectionReference messages = FirebaseFirestore.instance.collection('messages');

      return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy("createdAt", descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          if (snapshot.hasData) {
            List<Message> messagesList = snapshot.data!.docs.map((doc) {
              return Message.fromJson(doc.data() as Map<String, dynamic>);
            }).toList();
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
                appBar:AppBar(
                  automaticallyImplyLeading: true,
                  iconTheme: IconThemeData(color: Colors.white),
                  backgroundColor: color.primaryColor,
                  title: Row(
                    children: [
                      Image.asset(
                        AppAssets.chat,
                        width: 30.w,
                        height: 30.h,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "Community Chat",
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  centerTitle: true,
                ),
                body:  Column(
                    children: [
                      BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, state) {
                          if (state is ProfileLoaded) {
                            UserModel user = state.userModel;
                            return Expanded(
                              child: ListView.builder(
                                reverse: true,
                                controller: _controller,
                                itemCount: messagesList.length,
                                itemBuilder: (context, index) {
                                  Message msg = messagesList[index];
                                  DateTime messageDate = msg.createdAt.toDate();
                                  String formattedTime = DateFormat('hh:mm a').format(messageDate);
                                  String dateLabel = _getDateLabel(messageDate);

                                  return Column(
                                    crossAxisAlignment: msg.id == user.email
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                    children: [
                                      if (index == messagesList.length - 1 ||
                                          _getDateLabel(messagesList[index + 1].createdAt.toDate()) != dateLabel)
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: 8.h),
                                          child: Center(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade300,
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Text(
                                                dateLabel,
                                                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      Padding(
                                        padding: REdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: msg.id == user.email
                                              ? Alignment.centerRight
                                              : Alignment.centerLeft,
                                          child: Column(
                                            crossAxisAlignment: msg.id == user.email
                                                ? CrossAxisAlignment.end
                                                : CrossAxisAlignment.start,
                                            children: [
                                              if (msg.id != user.email)
                                                Padding(
                                                  padding: EdgeInsets.only(left: 12.w, right: 12.w),
                                                  child: Text(
                                                    msg.name ?? "Unknown",
                                                    style: TextStyle(
                                                      fontSize: 18.sp,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                ),
                                              BubbleNormal(
                                                text: msg.message,
                                                isSender: msg.id == user.email,
                                                color: msg.id == user.email
                                                    ? Color(0xffDCD9D9FF)
                                                    : color.secondColor,
                                                tail: true,
                                                textStyle: TextStyle(
                                                  fontSize: 24.sp,
                                                  color: msg.id == user.email ? Colors.black : Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: REdgeInsets.only(left: 16.w, top: 4.h, right: 16.w),
                                        child: Text(
                                          formattedTime,
                                          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),

                      BlocBuilder<ProfileCubit, ProfileState>(
                          builder: (BuildContext context, ProfileState state) {
                            UserModel? user;
                            if (state is ProfileLoaded) {
                              user = state.userModel;
                              return MessageBar(
                                messageBarHintStyle: TextStyle(fontSize: 20.sp),
                                messageBarHintText: "Enter your message",
                                sendButtonColor: color.secondColor,
                                onSend: (data) {
                                  messages.add({
                                  "message": data,
                                    "createdAt": Timestamp.now(),
                                    "id": user?.email,
                                    "name": user?.userName,
                                  });
                                  _textController.clear();
                                  _controller.animateTo(0,
                                      duration: Duration(seconds: 1),
                                      curve: Curves.fastOutSlowIn);
                                },
                              );
                            }

                            return Center(child: SizedBox());
                          }

                      ),
                    ],
                  ),
                ),

            );
          } else {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
        },
      );
    }
    String _getDateLabel(DateTime messageDate) {
      DateTime now = DateTime.now();
      DateTime today = DateTime(now.year, now.month, now.day);
      DateTime yesterday = today.subtract(Duration(days: 1));

      if (messageDate.isAfter(today)) {
        return "Today";
      } else if (messageDate.isAfter(yesterday)) {
        return "Yesterday";
      } else {
        return DateFormat('EEEE').format(messageDate); // 🔥 الرسالة من يوم آخر (Monday, Tuesday...)
      }
    }
  }