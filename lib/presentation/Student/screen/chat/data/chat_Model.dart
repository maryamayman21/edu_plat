import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String message;
  final Timestamp createdAt;
  final String id;
  final String? name;

  Message({required this.message, required this.createdAt,required this.id,required this.name});

  // Factory constructor to convert JSON data to Message object
  factory Message.fromJson(Map<String, dynamic> jsonData) {
    return Message(

      id: jsonData['id'] ?? '',
      message: jsonData['message'] ?? '', // إذا كان `null`، يتم إرجاع نص فارغ
      createdAt: jsonData['createdAt'] is Timestamp // التأكد من أن `createdAt` هو Timestamp
          ? jsonData['createdAt'] as Timestamp
          : Timestamp.now(),
      name: jsonData['name'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'createdAt': createdAt,
      'name': name,
    };
  }
}