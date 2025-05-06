
import 'package:dio/dio.dart';

import '../web_services/auth_web_service.dart';

class AuthRepository {
  final AuthWebService authWebService;

  AuthRepository(this.authWebService);
  Future<Response> register(String name, String email, String password, String confirmPassword) async {
    return await authWebService.register(name, email, password, confirmPassword);
  }

  Future<Response> login(String email, String password, String deviceToken) async {
    return await authWebService.login(email, password, deviceToken);
  }

  Future<Response> verifyEmail(String otp, String email) async {
    try {
      return await authWebService.verifyEmail(otp, email);
    } catch (e) {
      rethrow; // Pass the error to be handled by the Cubit
    }
  }

}


