
import 'package:dio/dio.dart';

import '../../../../core/constant/constant.dart';

class ForgetPassWebService {
  late Dio _dio;
  ForgetPassWebService() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
    ));
  }

  Future<Response> forgetPassword(String email) async {
    try {
      final response = await _dio.post(
        ApiConstants.forgetPassEndpoint,
        data: {
          'email': email,
        },
      );
      print('Forget Password response: ${response.data}'); // Debug print
      return response;
    } catch (e) {
      rethrow;
    }
  }
  Future<Response> verifyEmail(String otp) async {
    try {
      final response = await _dio.post(
        ApiConstants.validateOtpEndpoint,
        data: {
          'otp': otp,
        },
      );
      print('Verify OTP response: ${response.data}'); // Debug print
      return response;
    } catch (e) {
      rethrow;
    }
  }
  Future<Response> changePassword(String password , String confirmPassword, String userEmail) async {
    try {
      final response = await _dio.post(
        ApiConstants.resetPasswordEndpoint,
        data: {
          'newPassword': password,
          'confirmPassword' : confirmPassword,
          'email' : userEmail
        },
      );
      print('Change Password response: ${response.data}'); // Debug print
      return response;
    } catch (e) {
      rethrow;
    }
  }
  Future<Response> resetPassword( String currentPassword , String password , String confirmPassword , String token, String userEmail) async {
    try {
      final response = await _dio.post(
        ApiConstants.profileResetPasswordEndpoint,
        data: {
          'currentPassword' : currentPassword,
          'newPassword': password,
          'confirmPassword' : confirmPassword,
          //'email' : userEmail
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      print('Change Password response: ${response.data}'); // Debug print
      return response;
    } catch (e) {
      rethrow;
    }
  }

}