
import 'package:edu_platt/presentation/profile_update/domain/entity/user_entity.dart';

class UserModel  extends UserEntity{

  UserModel({
    required email,
    required userName,
  }) : super(
    userName: userName,
    email: email
  );

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
