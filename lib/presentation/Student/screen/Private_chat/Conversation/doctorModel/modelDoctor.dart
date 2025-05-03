import 'dart:convert';
import 'dart:typed_data';

class DoctorModel {
  final String id;
  final String name;
  final Uint8List? imageBytes;
  final String email;

  DoctorModel({
    required this.id,
    required this.name,
    required this.imageBytes,
    required this.email,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    print("🔹 Doctor JSON Data: $json");

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

    return DoctorModel(
      id: json['doctorId'].toString(),
      name: json['name'] ?? "Unknown",
      imageBytes: imageBytes,
      email: json['doctorEmail'] ?? "No Email",
    );
  }
}