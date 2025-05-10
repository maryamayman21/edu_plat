import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String message;
  final String senderId;
  final String receiverId;
  final Timestamp createdAt;
  final bool isRead;
  final String? id;



  ChatMessage({
    required this.message,
    required this.senderId,
    required this.receiverId,
    required this.createdAt,
    this.isRead = false,
    this.id,


  });

  // ✅ تحويل من JSON عند جلب البيانات من Firestore
  factory ChatMessage.fromJson(Map<String, dynamic> json, {String? id}) {
    return ChatMessage(
      id: id,
      message: json['message'] ?? '',
      senderId: json['senderId'] ?? '',
      receiverId: json['receiverId'] ?? '',
      createdAt: json['createdAt'] ?? Timestamp.now(),
      isRead: json['isRead'] ?? false,
    );
  }

  // ✅ تحويل إلى JSON عند إرسال البيانات إلى Firestore
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      "message": message,
      "senderId": senderId,
      "receiverId": receiverId,
      "createdAt": createdAt,
      'isRead': isRead,

    };
  }
}