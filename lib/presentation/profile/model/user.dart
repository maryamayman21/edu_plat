import 'dart:io';

class UserModel {
  final String email;
  final String userName;

  UserModel({
    required this.email,
    required this.userName,
  });

  UserModel copyWith({
    String? userName,
    String? email,
  }) {
    return UserModel(
      userName: userName ?? this.userName,
      email: email ?? this.email,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] ?? 'N/A', // Provide a default value
      userName: json['userName'] ?? 'N/A',

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'userName': userName,
    };
  }
}

//REGISTER -> OTP   OTP + EMAIL
