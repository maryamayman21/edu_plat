
import 'package:dio/dio.dart';

import '../../../../core/constant/constant.dart';

class AuthWebService {
  late Dio _dio;
  AuthWebService() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
    ));
  }

  Future<Response> register(String name, String email, String password, String confirmPassword) async {
    try {
      final response = await _dio.post(
        ApiConstants.registerEndpoint,
        data: {
          'userName': name,
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
        },
      );
      print('Register response: ${response.data}'); // Debug print
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> login(String email, String password, String deviceToken) async {

      final response = await _dio.post(ApiConstants.loginEndpoint, data: {
        'email': email,
        'password': password,
        'deviceToken': deviceToken
      });
     // print('Login response: ${response.data}'); // Debug print
      return response;
  }

  Future<Response> verifyEmail(String otp, String email) async {
    try {
      return await _dio.post(
        ApiConstants.verifyEmailEndpoint,
        data: {
          'otp': otp,
          'email':email
        },
      );
    } catch (e) {
      if (e is DioError) {
        // Log or inspect the error response for debugging
        print('API Error: ${e.response?.data}');
      }
      rethrow; // Rethrow the error to be handled by the Cubit
    }
  }Future<Response> resendOtp(String email) async {
    try {
      return await _dio.post(
        ApiConstants.resendOtpEndpoint,
        data: {
          'email':email
        },
      );
    } catch (e) {
      if (e is DioError) {
        // Log or inspect the error response for debugging
        print('API Error: ${e.response?.data}');
      }
      rethrow; // Rethrow the error to be handled by the Cubit
    }
  }



}