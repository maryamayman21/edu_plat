import 'package:dio/dio.dart';
import 'package:edu_platt/core/constant/constant.dart';

class DioClient {
  // Static field to hold the single instance
  static final DioClient _instance = DioClient._internal();

  // Dio instance
  late final Dio _dio;

  // Private constructor
  DioClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl:  ApiConstants.baseUrl, // Replace with your base URL
        connectTimeout: const Duration(seconds: 5), // 5 seconds
        receiveTimeout: const Duration(seconds: 3), // 3 seconds
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    // Add interceptors for logging or other middleware tasks
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('Request: ${options.method} ${options.path}');
          return handler.next(options); // Continue the request
        },
        onResponse: (response, handler) {
          print('Response: ${response.statusCode} ${response.data}');
          return handler.next(response); // Continue the response
        },
        onError: (error, handler) {
          print('Error: ${error.message}');
          return handler.next(error); // Continue the error
        },
      ),
    );
  }

  // Factory constructor to return the singleton instance
  factory DioClient() {
    return _instance;
  }

  // Getter to expose the Dio instance
  Dio get dio => _dio;

  // Optionally, add helper methods for common API operations
  Future<Response> get(String endpoint, {Map<String, dynamic>? queryParameters}) {
    return _dio.get(endpoint, queryParameters: queryParameters);
  }

  Future<Response> post(String endpoint, {dynamic data, Map<String, dynamic>? queryParameters}) {
    return _dio.post(endpoint, data: data, queryParameters: queryParameters);
  }

  Future<Response> put(String endpoint, {dynamic data, Map<String, dynamic>? queryParameters}) {
    return _dio.put(endpoint, data: data, queryParameters: queryParameters);
  }

  Future<Response> delete(String endpoint, {Map<String, dynamic>? queryParameters}) {
    return _dio.delete(endpoint, queryParameters: queryParameters);
  }
}
