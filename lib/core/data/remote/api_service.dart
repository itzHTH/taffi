import 'package:dio/dio.dart';
import 'package:taffi/core/constants/api_config.dart';
import 'package:taffi/core/data/remote/api_interceptor.dart';
import 'package:taffi/core/data/remote/server_exception.dart';

class ApiService {
  ApiService._() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: ApiConfig.connectTimeout,
        receiveTimeout: ApiConfig.receiveTimeout,
        sendTimeout: ApiConfig.sendTimeout,
      ),
    );
    _dio.interceptors.add(ApiInterceptor(_dio));
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
        request: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }

  static final ApiService instance = ApiService._();
  late final Dio _dio;

  Future<dynamic> get(String path) async {
    try {
      Response response = await _dio.get(path);
      return response.data;
    } on DioException catch (e) {
      throw _handleException(e);
    }
  }

  Future<dynamic> post(String path, {data}) async {
    try {
      Response response = await _dio.post(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw _handleException(e);
    }
  }

  Future<dynamic> put(String path, {data}) async {
    try {
      Response response = await _dio.put(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw _handleException(e);
    }
  }

  Future<dynamic> delete(String path) async {
    try {
      Response response = await _dio.delete(path);
      return response.data;
    } on DioException catch (e) {
      throw _handleException(e);
    }
  }
}

ServerException _handleException(DioException e) {
  String errorMessage = "حدث خطأ ما , يرجى المحاولة مرة اخرى";
  int? statusCode = e.response?.statusCode;

  // Check If The Server Is respons or Not
  if (e.response != null) {
    final response = e.response?.data;

    // Check If The Server Has A String Message
    if (response is String) {
      errorMessage = response;
    }
    // Check If The Server Has A Message
    else if (response is Map && response.containsKey('message')) {
      errorMessage = response['message'];
    }
    // Check If The Server Has A Generic Title
    else if (response.containsKey('title')) {
      errorMessage = response['title'];
    }
  } else {
    errorMessage = "هناك مشكلة في الاتصال بالخادم , يرجى المحاولة مرة اخرى";
  }

  return ServerException(message: errorMessage, statusCode: statusCode);
}
