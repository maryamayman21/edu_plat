import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String message;
  final String senderId;
  final String receiverId;
  final Timestamp createdAt;

  ChatMessage({
    required this.message,
    required this.senderId,
    required this.receiverId,
    required this.createdAt,
  });

  // ✅ تحويل من JSON عند جلب البيانات من Firestore
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      message: json['message'] ?? '',
      senderId: json['senderId'] ?? '',
      receiverId: json['receiverId'] ?? '',
      createdAt: json['createdAt'] ?? Timestamp.now(),
    );
  }

  // ✅ تحويل إلى JSON عند إرسال البيانات إلى Firestore
  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "senderId": senderId,
      "receiverId": receiverId,
      "createdAt": createdAt,
    };
  }
}