import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:taffi/core/constants/app_constants.dart';

class SecureStorage {
  SecureStorage._();

  static final SecureStorage instance = SecureStorage._();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveTokens(
    String accessToken,
    String refreshToken,
    String refreshTokenExpireAt,
  ) async {
    await _storage.write(key: AppConstants.accessToken, value: accessToken);
    await _storage.write(key: AppConstants.refreshToken, value: refreshToken);
    await _storage.write(key: AppConstants.refreshTokenExpireAt, value: refreshTokenExpireAt);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: AppConstants.accessToken);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: AppConstants.refreshToken);
  }

  Future<String?> getRefreshTokenExpireAt() async {
    return await _storage.read(key: AppConstants.refreshTokenExpireAt);
  }

  Future<void> deleteTokens() async {
    await _storage.delete(key: AppConstants.accessToken);
    await _storage.delete(key: AppConstants.refreshToken);
    await _storage.delete(key: AppConstants.refreshTokenExpireAt);
  }
}
