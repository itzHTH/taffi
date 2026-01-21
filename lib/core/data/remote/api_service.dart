import 'package:dio/dio.dart';
import 'package:taffi/core/constants/api_config.dart';
import 'package:taffi/core/data/remote/api_interceptor.dart';
import 'package:taffi/core/data/remote/server_error.dart';

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
    } on ServerError catch (e) {
      throw ServerError(message: e.message, statusCode: e.statusCode);
    }
  }

  Future<dynamic> post(String path, {data}) async {
    try {
      Response response = await _dio.post(path, data: data);
      return response.data;
    } on ServerError catch (e) {
      throw ServerError(message: e.message, statusCode: e.statusCode);
    }
  }

  Future<dynamic> put(String path, {data}) async {
    try {
      Response response = await _dio.put(path, data: data);
      return response.data;
    } on ServerError catch (e) {
      throw ServerError(message: e.message, statusCode: e.statusCode);
    }
  }

  Future<dynamic> delete(String path) async {
    try {
      Response response = await _dio.delete(path);
      return response.data;
    } on ServerError catch (e) {
      throw ServerError(message: e.message, statusCode: e.statusCode);
    }
  }
}
