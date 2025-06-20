import 'package:bloc/bloc.dart';
import 'package:edu_platt/services/push_notification_service.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import '../../../core/localDB/secureStorage/secure_stoarge.dart';
import '../../../core/network_handler/network_handler.dart';
import '../data/repository/auth_repository.dart'; // Import Dio for error handling

part 'auth_state.dart';

enum AuthPasswordVisibility { visible, hidden }

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  AuthPasswordVisibility _passwordVisibility = AuthPasswordVisibility.hidden;

  AuthCubit(this.authRepository) : super(AuthInitial());

  Future<void> register(String name, String email, String password, String confirmPassword) async {
    emit(AuthLoading());
    try {
      final response = await authRepository.register(name, email, password, confirmPassword);

      // Parse the response data
      final responseData = response.data;
      if (responseData['success'] == true) {
        final message = responseData['message'] ?? 'Registration successful.';
        emit(AuthSuccess(message));
      } else {
        final message = responseData['message'] ?? 'Registration Failed.';

        // Handle unexpected cases where 'success' is false or missing
        emit(AuthFailure(message));
      }
    } catch (error) {
      // Map the error to a user-friendly message and emit failure state
      emit(AuthFailure(NetworkHandler.mapErrorToMessage(error)));
    }
  }


  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
       String? deviceToken = await  PushNotificationsService.getDeviceToken();
       final response = await authRepository.login(email, password, deviceToken!);

      final data = response.data;
       if(data['success'] == true){
         final token = data['userData']['token'];
         final roles = data['userData']['roles'] as List<dynamic>;
         final expiration = data['userData']['expiration'];
         final prefs = await SharedPreferences.getInstance();

         await SecureStorageService.write('token', token);
         //await prefs.setString('expiration', expiration);
         await SecureStorageService.write('expiration', expiration);
         await prefs.setBool('isLogged', true);
         await SecureStorageService.write('role', roles.isNotEmpty ? roles.first.toString() : '');
         final message = data['message'] ?? 'Login successful';
         emit(AuthSuccess(message));
       }else if(data['success'] == false){
         emit(AuthFailure(data['message']));
       }
    } catch (error) {
      emit(AuthFailure(NetworkHandler.mapErrorToMessage(error)));
    }
  }

  Future<void> verifyEmail(String otp, String email) async {
    emit(AuthLoading());
    try {
      final response = await authRepository.verifyEmail(otp, email);

      // Assuming the response has a `success` field
      final success = response.data['success'];

      if (success == true) {
        final message = response.data['message'] ?? 'Verification Successful.';

        emit(AuthSuccess(message));
      } else {
        final message = response.data['message'] ?? 'Verification Failed.';

        emit(AuthFailure(message));
      }
    } catch (error) {
      if (error is DioError && error.response != null) {
        // Handle specific API errors
        final errorMessage = error.response?.data['message'] ??
            'An unexpected error occurred';
        emit(AuthFailure(errorMessage));
      } else {
        // Handle other unexpected errors
        emit(AuthFailure(NetworkHandler.mapErrorToMessage(error)));
      }
    }
  }


  Future<void> resendOtp(String email) async {
  //  emit(AuthLoading());
    try {
      final response = await authRepository.resendOtp(email);

      // Assuming the response has a `success` field
      final success = response.data['success'];

      if (success == true) {
        final message = response.data['message'] ?? 'OTP send successfully, please check your email.';

        emit(ResendCodeSuccess(successMessage: message));
      } else {
        final message = response.data['message'] ?? 'Error occurred in requesting OTP';

        emit(ResendCodeFailure(errorMessage: message));
      }
    } catch (error) {
      if (error is DioError && error.response != null) {
        // Handle specific API errors
        final errorMessage = error.response?.data['message'] ?? 'An unexpected error occurred';
        emit(AuthFailure(errorMessage));
      } else {
        // Handle other unexpected errors
        emit(AuthFailure(NetworkHandler.mapErrorToMessage(error)));
      }
    }
  }



  void togglePasswordVisibility() {
    _passwordVisibility = _passwordVisibility == AuthPasswordVisibility.hidden
        ? AuthPasswordVisibility.visible
        :AuthPasswordVisibility.hidden;
    emit(AuthPasswordVisibilityChanged(_passwordVisibility));
  }









}