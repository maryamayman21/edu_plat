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
import 'package:shared_preferences/shared_preferences.dart';

class DoctorPrivatechat extends StatefulWidget {
  final String studentName;
  final String studentEmail;
  DoctorPrivatechat({required this.studentEmail, required this.studentName,});
  @override
  State<DoctorPrivatechat> createState() => _DoctorPrivatechatState();
}

class _DoctorPrivatechatState extends State<DoctorPrivatechat> {
  @override
  void initState() {
    super.initState();
    _saveLastOpenedTime();
    // إعلام الطرف الآخر بأن الرسائل قد قرئت
    _markMessagesAsRead();
  }
  void _saveLastOpenedTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastOpenedPrivate', DateTime.now().millisecondsSinceEpoch);
  }

  void _markMessagesAsRead() async {
    final profileState = context.read<ProfileCubit>().state;
    final currentUserEmail = profileState is ProfileLoaded ? profileState.userModel.email : "";

    if (currentUserEmail.isEmpty) return;

    final roomId = "${widget.studentEmail}_${currentUserEmail}";

    // تحديث جميع الرسائل المرسلة للطرف الحالي كمقروءة
    final query = await FirebaseFirestore.instance
        .collection('chats')
        .doc(roomId)
        .collection('messages')
        .where('receiverId', isEqualTo: currentUserEmail)
        .get();

    final batch = FirebaseFirestore.instance.batch();
    for (final doc in query.docs) {
      batch.update(doc.reference, {'isRead': true});
    }
    await batch.commit();
  }


  @override
  Widget build(BuildContext context) {
    String doctorEmail = "";
    final profileState = context.watch<ProfileCubit>().state;
    if (profileState is ProfileLoaded) {
      doctorEmail = profileState.userModel.email ?? "";
      print("✅ Loaded doctor Email: $doctorEmail");
    }
    if (doctorEmail.isEmpty) {
      print("⚠️ Doctor email is empty! Cannot generate room ID.");
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final String roomId = "${widget.studentEmail}_${doctorEmail}";

    print("Generated Room ID: $roomId");

    print("✅ Navigating to chat with Room ID: $roomId and Doctor: $doctorEmail");
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
              widget.studentName,
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
                          crossAxisAlignment: msg.senderId == doctorEmail
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            BubbleNormal(
                              text: msg.message,
                              isSender:  msg.senderId == doctorEmail,
                              color: msg.senderId == doctorEmail?Color(0xFFD1DEE8): color.secondColor,
                              tail: true,
                              textStyle: TextStyle(
                                fontSize: 24.sp,
                                color: msg.senderId == doctorEmail ? Colors.black : Colors.white,
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

              print("doctor Email Before Sending Message: $doctorEmail");

              messages.add({
                "message": data,
                "createdAt": Timestamp.now(),
                "senderId": doctorEmail ,
                "receiverId": widget.studentEmail,
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
