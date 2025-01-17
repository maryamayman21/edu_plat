
import 'package:dio/dio.dart';

import '../web_services/web_services.dart';
class ForgetPassRepository {
  final ForgetPassWebService forgetPassWebService;

  ForgetPassRepository(this.forgetPassWebService);
  Future<Response> forgetPassword(String email,) async {
    return await forgetPassWebService.forgetPassword(email);
  }
  Future<Response> verifyEmail(String otp) async {
    return await forgetPassWebService.verifyEmail(otp);
  }
  Future<Response> changePassword(String password, String confirmPassword) async {
    return await forgetPassWebService.changePassword(password , confirmPassword);
  }
  Future<Response> resetPassword( String currentPassword, String password, String confirmPassword , String token) async {
    return await forgetPassWebService.resetPassword( currentPassword, password , confirmPassword, token );
  }
}


