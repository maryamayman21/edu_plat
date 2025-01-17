import 'package:bloc/bloc.dart';
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
        // Handle unexpected cases where 'success' is false or missing
        emit(const AuthFailure('Registration failed. Please try again.'));
      }
    } catch (error) {
      // Map the error to a user-friendly message and emit failure state
      emit(AuthFailure(NetworkHandler.mapErrorToMessage(error)));
    }
  }


  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      // Make the login POST request
      final response = await authRepository.login(email, password);

      // Extract the token and other relevant data from the response
      final data = response.data;
      final token = data['token'];
      final roles = data['roles'] as List<dynamic>;
      final expiration = data['expiration'];

      if (token == null) {
        emit(const AuthFailure('Login failed: Token is null.'));
        return;
      }

      // Save the token and expiration date using SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      //await prefs.setString('token', token);
      await SecureStorageService.write('token', token);
      //await prefs.setString('expiration', expiration);
      await SecureStorageService.write('expiration', expiration);
      await prefs.setBool('isLogged', true);
     // await prefs.setString('role', roles.isNotEmpty ? roles.first.toString() : '');
      await SecureStorageService.write('role', roles.isNotEmpty ? roles.first.toString() : '');
      emit(AuthSuccess('Login successful!'));
    } catch (error) {
      emit(AuthFailure(NetworkHandler.mapErrorToMessage(error)));
    }
  }

  Future<void> verifyEmail(String otp) async {
    emit(AuthLoading());
    try {
      final response = await authRepository.verifyEmail(otp);

      // Assuming the response has a `success` field
      final success = response.data['success'];
      final message = response.data['message'] ?? 'Verification successful';

      if (success == true) {
        emit(AuthSuccess(message));
      } else {
        emit(AuthFailure(message));
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