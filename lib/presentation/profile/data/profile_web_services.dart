import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../../core/constant/constant.dart';

class ProfileWebServices {
  late Dio _dio;

  ProfileWebServices(){
    _dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: Duration(seconds: 10)
    ));
  }

  Future<Response> uploadPhoto(String token,  File? image) async {
    try {
      FormData formData = FormData.fromMap({
        "profilePicturee": await MultipartFile.fromFile(image!.path, filename: image!.path.split('/').last),
      });

      return await _dio.post(
        ApiConstants.profilePhotoEndpoint, // Replace with your endpoint
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
    } catch (e) {
      throw Exception('Failed to upload photo: $e');
    }
  }
  Future<Response> fetchPhoto(String token) async {
    try {
      print('GOT HERE');
      return await _dio.get(
        ApiConstants.profilePhotoEndpoint, // Replace with your endpoint
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
    } catch (e) {
      throw Exception('Failed to fetch photo: $e');
    }
  }
  Future<Response> updatePhoneNumber(String token , String phoneNumber) async {
    try {
      return await _dio.post(
        ApiConstants.userUpdatePhoneNumberEndpoint, // Replace with your endpoint
        data: {
          'newPhoneNumber': phoneNumber,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
    } catch (e) {
      throw Exception('Failed to update phone number : $e');
    }
  }
  Future<Response> fetchPhoneNumber(String token ) async {
    try {
      return await _dio.get(
        ApiConstants.userFetchPhoneNumberEndpoint, // Replace with your endpoint
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
    } catch (e) {
      throw Exception('Failed to fetch phone number: $e');
    }
  }

  Future<Response> fetchUserDate(String token,) async {
    try {
      final response =  await _dio.get(
        ApiConstants.userProfileEndpoint, // Replace with your endpoint
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      print('Data fetched successfully!');
      return response;
    } catch (e) {
      throw Exception('Failed to fetch user data: $e');
    }
  }
}




