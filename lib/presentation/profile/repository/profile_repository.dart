// profile_repository.dart


import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../data/profile_web_services.dart';
import '../model/user.dart';

class ProfileRepository {
  final ProfileWebServices webServices;

  ProfileRepository(this.webServices);

  Future<void> uploadProfilePhoto(String token , File? image) async {
    final response = await webServices.uploadPhoto(token , image);
    if (response.statusCode == 200) {
      // Handle successful upload
      print('Photo uploaded successfully!');
    } else {
      // Handle failure
      throw Exception('Failed to upload photo: ${response.data}');
    }
  }
  Future<String?> fetchProfilePhoto(String token ) async {
    final response = await webServices. fetchPhoto(token);
    print('GOT HERE in repo');
    if (response.statusCode == 200) {
      // Handle successful upload
      print('Photo fetched successfully!');
      return  response.data['profilephoto'];

    } else {
      // Handle failure
      throw Exception('Failed to fetch photo: ${response.data}');
    }
  }

  Future<void> updatePhoneNumber(String token , String phoneNumber) async {
    final response = await webServices.updatePhoneNumber(token , phoneNumber);
    if (response.statusCode == 200) {
      // Handle successful upload
      print('Phone number updated successfully!');
    } else {
      // Handle failure
      throw Exception('Failed to update phone number : ${response.data}');
    }
  }
  Future<dynamic> fetchPhoneNumber(String token) async {
    final response = await webServices.fetchPhoneNumber(token);
    if (response.statusCode == 200) {
      // Handle successful upload
      print('Phone number fetched successfully!');
      return response.data['phoneNumber'];
    } else {
      // Handle failure
      throw Exception('Failed to fetch phone number : ${response.data}');
    }
  }
  Future<UserModel> fetchUserData(String token) async {
    final response = await webServices.fetchUserDate(token);
    if (response.statusCode == 200) {
      // Handle successful upload
      print('User data fetched successfully!');
      return UserModel.fromJson(response.data);
    } else {
      // Handle failure
      throw Exception('Failed to fetch user data : ${response.data}');
    }
  }

}