import 'package:dio/dio.dart';
import 'package:taffi/core/constants/api_config.dart';
import 'package:taffi/core/constants/app_constants.dart';
import 'package:taffi/core/data/local/secure_storage.dart';
import 'package:taffi/core/routing/route_names.dart';
import 'package:taffi/core/services/navigation_service.dart';

class ApiInterceptor extends QueuedInterceptorsWrapper {
  final Dio _dio;

  ApiInterceptor(this._dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Add token to request headers
    final String? token = await SecureStorage.instance.getAccessToken();
    if (token != null) {
      options.headers["Authorization"] = "Bearer $token";
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // if the refresh token is got an error (refresh token is expired) => logout
      if (err.requestOptions.path.contains(EndPoints.auth.refreshToken)) {
        await SecureStorage.instance.deleteTokens();
        NavigationService().pushNamedAndRemoveUntil(RouteNames.splash);
        return handler.next(err);
      }

      try {
        final String? oldToken = await SecureStorage.instance.getAccessToken();
        final String? refreshToken = await SecureStorage.instance.getRefreshToken();

        // create a new dio instance to avoid infinite loop
        final Dio tokenDio = Dio(
          BaseOptions(
            baseUrl: ApiConfig.baseUrl,
            connectTimeout: ApiConfig.connectTimeout,
            receiveTimeout: ApiConfig.receiveTimeout,
            sendTimeout: ApiConfig.sendTimeout,
          ),
        );

        tokenDio.interceptors.add(
          LogInterceptor(
            requestBody: true,
            responseBody: true,
            error: true,
            request: true,
            requestHeader: true,
            responseHeader: true,
          ),
        );

        final Response response = await tokenDio.post(
          EndPoints.auth.refreshToken,
          data: {AppConstants.accessToken: oldToken, AppConstants.refreshToken: refreshToken},
        );

        if (response.statusCode == 200) {
          final String newAccessToken = response.data[AppConstants.accessToken];
          final String newRefreshToken = response.data[AppConstants.refreshToken];
          final String newRefreshTokenExpireAt = response.data[AppConstants.refreshTokenExpireAt];
          await SecureStorage.instance.saveTokens(
            newAccessToken,
            newRefreshToken,
            newRefreshTokenExpireAt,
          );

          // clone request options to edit the headers
          final opts = err.requestOptions;
          opts.headers["Authorization"] = "Bearer $newAccessToken";

          // retry the request with the new access token (skip the error interceptor)
          return handler.resolve(await _dio.fetch(opts));
        }

        return handler.next(err);
      } catch (e) {
        return handler.next(err);
      }
    }
    super.onError(err, handler);
  }
}
