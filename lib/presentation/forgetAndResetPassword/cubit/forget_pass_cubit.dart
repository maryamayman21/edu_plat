import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../data/repository/repository.dart';

part 'forget_pass_state.dart';

class ForgetPassCubit extends Cubit<ForgetPassState> {
  final ForgetPassRepository forgetRepository;

  ForgetPassCubit( this. forgetRepository) : super(ForgetPassInitial());


  Future<void> forgetPassword( String email) async {
    emit(ForgetPassLoading());
    try {
      final response = await  forgetRepository.forgetPassword(email);

      // Parse the response data
      final responseData = response.data;
      if (responseData['success'] == true) {
        final message = responseData['message'] ?? 'successful.';
        emit(ForgetPassSuccess(message));
      } else {
        // Handle unexpected cases where 'success' is false or missing
        emit( ForgetPassFailure('Request failed. Please try again.'));
      }
    } catch (error) {
      // Map the error to a user-friendly message and emit failure state
      emit(ForgetPassFailure(_mapErrorToMessage(error)));
    }
  }

  Future<void> verifyEmail(String otp, String email) async {
    emit(ForgetPassLoading());
    try {
      final response = await forgetRepository.verifyEmail(otp, email);

      // Assuming the response has a `success` field
      final success = response.data['success'];
    //  final message = response.data['message'] ?? 'Verification successful';

      if (success == true) {
        final message = response.data['message'] ?? 'Verification successful';

        emit(OTPVerifiedSuccess(message));
      } else {
        final message = response.data['message'] ?? 'Verification Failed';

        emit(ForgetPassFailure(message));
      }
    } catch (error) {
      if (error is DioError && error.response != null) {
        // Handle specific API errors
        final errorMessage = error.response?.data['message'] ?? 'An unexpected error occurred';
        emit(ForgetPassFailure(errorMessage));
      } else {
        // Handle other unexpected errors
        emit(ForgetPassFailure(_mapErrorToMessage(error)));
      }
    }
  }



  Future<void> changePassword( String password, String confirmPassword, String userEmail) async {
    emit(ForgetPassLoading());
    try {
      final response = await forgetRepository.changePassword(password, confirmPassword, userEmail);

      // Parse the response data
      final responseData = response.data;
      if (responseData['success'] == true) {
        final message = responseData['message'] ?? 'Reset password successful.';
        emit(ForgetPassSuccess(message));
      } else {
        final message = responseData['message'] ?? 'Reset password failed';
        // Handle unexpected cases where 'success' is false or missing
        emit( ForgetPassFailure(message));
      }
    } catch (error) {
      // Map the error to a user-friendly message and emit failure state
      emit(ForgetPassFailure(_mapErrorToMessage(error)));
    }
  }

  Future<void> resetPassword( String currentPassword  , String password, String confirmPassword , String token, String userEmail) async {
    emit(ForgetPassLoading());
    try {
      final response = await forgetRepository.resetPassword( currentPassword, password, confirmPassword, token, userEmail);

      // Parse the response data
      final responseData = response.data;
      if (responseData['success'] == true) {
        final message = responseData['message'] ?? 'Reset password successful.';

        emit(ForgetPassSuccess(message));
      } else {
        final message = responseData['message'] ?? 'Reset password failed.';

        // Handle unexpected cases where 'success' is false or missing
        emit( ForgetPassFailure(message));
      }
    } catch (error) {
      // Map the error to a user-friendly message and emit failure state
      emit(ForgetPassFailure(_mapErrorToMessage(error)));
    }
  }




  String _mapErrorToMessage(dynamic error) {
    if (error is DioException) {
      if (error.response != null) {
        // Server error with response
        final responseBody = error.response!.data;
        return _parseBadRequestError(responseBody);
      } else {
        // Network error
        return 'Network error. Please check your internet connection.';
      }
    } else {
      // Unknown error
      return 'An unexpected error occurred. Please try again.';
    }
  }

  String _parseBadRequestError(dynamic responseBody) {
    if (responseBody is Map<String, dynamic>) {
      // Check for the `status` field
      final message = responseBody['message'];

      // Check for the `data` field which contains specific error details
      final data = responseBody['data'];

      if (data is List<dynamic> && data.isNotEmpty) {
        // Extract detailed error messages
        final errorDetails = data.firstWhere(
                (item) => item is Map<String, dynamic>,
            orElse: () => {});

        final field = errorDetails['field'] ?? '';
        final errorMsg = errorDetails['msg'] ?? 'Unknown error';

        // Return the specific error message
        return '$field $errorMsg';
      }

      // Fallback to a general message if no specific errors are found
      return message ?? 'Invalid. Please check the provided data.';
    }

    // Default fallback message if response body is not in expected format
    return 'Invalid input. Please check the provided data.';
  }


}
