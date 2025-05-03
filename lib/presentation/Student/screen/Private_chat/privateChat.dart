import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_platt/core/utils/Assets/appAssets.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Student/screen/Private_chat/Model/modelPrivateChat.dart';
import 'package:edu_platt/presentation/profile/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class Privatechat extends StatefulWidget {
  final String doctorName;
  final String doctorEmail;
  Privatechat({required this.doctorEmail, required this.doctorName,});
  @override
  State<Privatechat> createState() => _PrivatechatState();
}

class _PrivatechatState extends State<Privatechat> {

  @override
  Widget build(BuildContext context) {

    String studentEmail = "";
    final profileState = context.read<ProfileCubit>().state;
    if (profileState is ProfileLoaded) {
      studentEmail = profileState.userModel.email ?? "";
      print("✅ Loaded Student Email: $studentEmail"); // تحقق من تحميل البريد الإلكتروني

    }
    if (studentEmail.isEmpty) {
      print("❌ studentEmail is empty! Retrying...");
    }
    if (studentEmail == widget.doctorEmail) {
      print("⚠️ الطالب والدكتور لهما نفس البريد الإلكتروني! تأكد من تحميل البريد الصحيح.");
    }

    final String roomId = "${studentEmail}_${widget.doctorEmail}";
    print("Generated Room ID: $roomId");
    print("✅ Navigating to chat with Room ID: $roomId and Doctor: $widget.doctorName");
    assert(roomId.isNotEmpty, "Room ID must not be empty");
    final ScrollController _controller = ScrollController();
    final CollectionReference messages = FirebaseFirestore.instance
        .collection('chats')
        .doc(roomId)
        .collection('messages');
    return  Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
        backgroundColor: color.primaryColor,
        title: Row(
              children: [
                SizedBox(width: 30.w),
                Image.asset(
                  AppAssets.chat,
                  width: 30.w,
                  height: 30.h,
                ),
                SizedBox(width: 8.w),
                Text(
                  widget.doctorName,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: messages.orderBy("createdAt", descending: true).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("No messages yet",style: TextStyle(fontSize: 25.sp,color: color.primaryColor),));
                }
                print("Fetched Messages: ${snapshot.data!.docs.map((doc) => doc.data()).toList()}");

                List<ChatMessage> messagesList = snapshot.data!.docs.map((doc) {
                  return ChatMessage.fromJson(doc.data() as Map<String, dynamic>);
                }).toList();

                return ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    ChatMessage msg = messagesList[index];
                    DateTime messageDate = msg.createdAt.toDate();
                    String formattedTime = DateFormat('hh:mm a').format(messageDate);
                    String dateLabel = _getDateLabel(messageDate);

                    return Column(
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

                        Column(
                                crossAxisAlignment: msg.senderId == studentEmail
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  BubbleNormal(
                                    text: msg.message,
                                    isSender: msg.senderId == studentEmail,
                                    color: msg.senderId == studentEmail ? Color(0xFFD1DEE8) : color.secondColor,
                                    tail: true,
                                    textStyle: TextStyle(
                                      fontSize: 24.sp,
                                      color: msg.senderId == studentEmail ? Colors.black : Colors.white,
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
                              ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          MessageBar(
                  messageBarHintStyle: TextStyle(fontSize: 20.sp),
                  messageBarHintText: "Enter your message",
                  sendButtonColor: color.secondColor,
                  onSend: (data) {
                    print("Student Email Before Sending Message: $studentEmail");

                    messages.add({
                      "message": data,
                      "createdAt": Timestamp.now(),
                      "senderId": studentEmail.isNotEmpty ? studentEmail : "UNKNOWN",
                      "receiverId": widget.doctorEmail,
                    }).then((_) {
                      setState(() {});
                    });

                    _controller.animateTo(
                      0,
                      duration: Duration(seconds: 1),
                      curve: Curves.fastOutSlowIn,
                    );
                  },
          ),
        ],
      ),
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
      return DateFormat('EEEE').format(
          messageDate);
    }
  }

}
