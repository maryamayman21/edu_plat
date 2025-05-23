import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_platt/core/cashe/services/course_cashe_service.dart';
import 'package:edu_platt/core/cashe/services/notes_cache_service.dart';
import 'package:edu_platt/core/cashe/services/profile_cashe_service.dart';
import 'package:edu_platt/core/file_picker/file_picker_service.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Auth/service/token_service.dart';
import 'package:edu_platt/presentation/profile/cubit/profile_cubit.dart';
import 'package:edu_platt/presentation/profile/data/profile_web_services.dart';
import 'package:edu_platt/presentation/profile/repository/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';


class ChatgroupScreen extends StatefulWidget {
  final String courseCode;


  const ChatgroupScreen({super.key, required this.courseCode});

  @override
  State<ChatgroupScreen> createState() => _ChatgroupScreenState();
}

class _ChatgroupScreenState extends State<ChatgroupScreen> {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    CollectionReference messages = FirebaseFirestore.instance
        .collection('group_chats')
        .doc(widget.courseCode)
        .collection('messages');
    return BlocProvider(
      create: (context) => ProfileCubit(
        profileRepository: ProfileRepository(ProfileWebServices()),
        tokenService: TokenService(),
        filePickerService: FilePickerService(),
        profileCacheService: ProfileCacheService(),
        courseCacheService: CourseCacheService(),
        notesCacheService: NotesCacheService(),
      )..getProfileData(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: color.primaryColor,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Group Chat - ${widget.courseCode}',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: messages.orderBy('timestamp', descending: true).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final chatDocs = snapshot.data!.docs;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: chatDocs.length,
                    itemBuilder: (context, index) {
                      final msg = chatDocs[index];
                      final data = msg.data() as Map<String, dynamic>;

                      final message = data['text'] ?? '';
                      final senderId = data['senderId'] ?? '';
                      final senderName = data['name'] ?? 'Unknown';
                      final timestamp = (data['timestamp'] as Timestamp).toDate();

                      final formattedTime = DateFormat('hh:mm a').format(timestamp);
                      final dateLabel = _getDateLabel(timestamp);

                      return BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, state) {
                          if (state is ProfileLoaded) {
                            final user = state.userModel;

                            return Column(
                              crossAxisAlignment: senderId == user?.email
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                if (index == chatDocs.length - 1 ||
                                    _getDateLabel((chatDocs[index + 1]['timestamp'] as Timestamp).toDate()) != dateLabel)
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
                                    alignment: senderId == user.email
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment: msg.id == user.email
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                      children: [
                                        if (senderId!=user.email)
                                          Padding(
                                            padding: EdgeInsets.only(left: 12.w, right: 12.w),
                                            child: Text(
                                              senderName ?? "Unknown",
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ),
                                        BubbleNormal(
                                          text: message,
                                          isSender: senderId == user.email,
                                          color: senderId == user.email
                                              ? Color(0xffDCD9D9FF)
                                              : color.secondColor,
                                          tail: true,
                                          textStyle: TextStyle(
                                            fontSize: 24.sp,
                                            color: senderId == user.email ? Colors.black : Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 4.h),
                                  child: Text(
                                    formattedTime,
                                    style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Colors.grey),
                                  ),
                                ),
                              ],
                            );
                          }
                          return const SizedBox();
                        },
                      );
                    },
                  ),
                ),
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileLoaded) {
                      final user = state.userModel;

                      return MessageBar(
                        messageBarHintText: "Type your message...",
                        sendButtonColor: color.secondColor,
                        onSend: (text) {
                          messages.add({
                            'text': text,
                            'senderId': user?.email,
                            'timestamp': Timestamp.now(),
                            "name": user?.userName,
                          });
                          _controller.animateTo(0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut);
                        },
                      );
                    }
                    return const SizedBox();
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }

  String _getDateLabel(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    if (date.isAfter(today)) return 'Today';
    if (date.isAfter(yesterday)) return 'Yesterday';
    return DateFormat('EEE, MMM d').format(date); // ex: Wed, Apr 10
  }
}
