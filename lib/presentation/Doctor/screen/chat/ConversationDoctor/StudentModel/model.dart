import 'dart:convert';

import 'package:flutter/foundation.dart';

class StudentModel {
  final String id;
  final String name;
  final Uint8List? imageBytes;
  final String email;

  StudentModel({
    required this.id,
    required this.name,
    required this.imageBytes,
    required this.email,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    print("🔹 Student JSON Data: $json");

    Uint8List? imageBytes;

    if (json['profilePicture'] != null && json['profilePicture'] is String &&
        json['profilePicture'].isNotEmpty) {
      try {
        imageBytes = base64Decode(json['profilePicture']);
      } catch (e) {
        print("❌ Error decoding Base64 image: $e");
        imageBytes = null;
      }
    }

    return StudentModel(
      id: json['studentId'].toString(),
      name: json['name'] ?? "Unknown",
      imageBytes: imageBytes,
      email: json['studentEmail'] ?? "No Email",
    );
  }
}