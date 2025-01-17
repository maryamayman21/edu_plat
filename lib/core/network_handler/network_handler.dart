import 'dart:io';

import 'package:dio/dio.dart';

class NetworkHandler{


 static String mapErrorToMessage(dynamic error) {

   if(error is SocketException){
     return 'No internet connection';
   }
    else if (error is DioException) {

      if (error.type == DioExceptionType.connectionTimeout) {
        return 'Connection timed out';
      } else if (error.type == DioExceptionType.receiveTimeout) {
        return 'Receive timeout ' ;
      } else if (error.type == DioExceptionType.badCertificate) {
        return 'Bad certificate';
      } else if (error.type == DioExceptionType.badResponse) {
        return 'Bad response: ${error.response?.statusCode}';
      } else if (error.type == DioExceptionType.connectionError) {
        return 'No internet connection';
      }

      if (error.response != null) {
        // Server error with response
        final responseBody = error.response!.data;
       // final errorMessage = error.response?.data['connection error'] ?? 'Poor connection, please try again later.';
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

  static String _parseBadRequestError(dynamic responseBody) {

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