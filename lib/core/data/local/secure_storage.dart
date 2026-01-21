import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:taffi/core/constants/app_constants.dart';

class SecureStorage {
  SecureStorage._();

  static final SecureStorage instance = SecureStorage._();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _storage.write(key: AppConstants.accessToken, value: accessToken);
    await _storage.write(key: AppConstants.refreshToken, value: refreshToken);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: AppConstants.accessToken);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: AppConstants.refreshToken);
  }

  Future<void> deleteTokens() async {
    await _storage.delete(key: AppConstants.accessToken);
    await _storage.delete(key: AppConstants.refreshToken);
  }
}
