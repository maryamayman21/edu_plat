
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

  Future<Response> login(String email, String password) async {
    try {
      final response = await _dio.post(ApiConstants.loginEndpoint, data: {
        'email': email,
        'password': password,
      });
      print('Login response: ${response.data}'); // Debug print
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> verifyEmail(String otp) async {
    try {
      return await _dio.post(
        ApiConstants.verifyEmailEndpoint,
        data: {
          'otp': otp,
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