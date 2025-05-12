import 'package:dio/dio.dart';
import 'package:edu_platt/core/constant/constant.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  late final Dio _dio;

  final String baseUrl = ApiConstants.baseUrl; // Replace with your actual base URL

  factory ApiService() {
    return _instance;
  }
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  ApiService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );


    // Add interceptor to attach token to requests
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        String? token = await _secureStorage.read(key: 'token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException error, handler) async {
        return handler.reject(error);
      },
    ));


  }



  /// Save token securely after login
  Future<void> saveToken({required String accessToken}) async {
    await _secureStorage.write(key: 'access_token', value: accessToken);
  }

  /// Remove token (logout)
  Future<void> clearToken() async {
    await _secureStorage.delete(key: 'access_token');
  }


  Future<Response> get({
    required String endPoint,
    Map<String, dynamic>? data,
  }) async {
    return await _dio.get(
      endPoint,
      data: data,
      // If data is meant for query params
    );
  }

  Future<Response> getFromUrl({
    required String endPoint,
  }) async {
    return await _dio.get(
      endPoint,
    );
  }

  Future<Response> postFormData({
    required String endPoint,
    required  FormData formData
  }) async {
    return await _dio.post(endPoint, data: formData,
    );
  }

  /// POST request
  Future<Response> post({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    return await _dio.post(endPoint, data: data,
    );
  }

  /// PUT request
  Future<Response> putFormData({
    required String endPoint,
    required  FormData formData
  }) async {
    var response = await _dio.put('$baseUrl$endPoint', data: formData);
    return response;
  }

  /// DELETE request
  Future<Response> delete({required String endPoint,
    Map<String, dynamic>? data,
  }) async {
    var response = await _dio.delete(
        endPoint,
      data: data
    );
    return response;
  }
  /// PUT request to update data
  Future<Response> update({
    required String endPoint,
    required Map<String, dynamic>? data,
  }) async {
    var response = await _dio.put(
      endPoint,
      data: data,
    );
    return response;
  }


  /// PATCH request
  Future<Map<String, dynamic>> patch({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    var response = await _dio.patch('$baseUrl$endPoint', data: data);
    return response.data;
  }
}
