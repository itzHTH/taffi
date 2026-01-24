import 'package:flutter/material.dart';
import 'package:taffi/core/constants/api_config.dart';
import 'package:taffi/core/data/local/secure_storage.dart';
import 'package:taffi/core/data/remote/api_service.dart';
import 'package:taffi/core/data/remote/server_exception.dart';
import 'package:taffi/core/enums/status_enum.dart';
import 'package:taffi/features/auth/models/auth_model.dart';

class RegisterProvider extends ChangeNotifier {
  String? errorMessage;
  Status status = Status.initial;
  bool isGoogleLogin = false;

  String? name;
  String? phone;
  String? age;
  String? governorate;
  String? username;
  String? email;
  String? password;

  Future<void> saveFirstForm({
    required String username,
    required String email,
    required String password,
  }) async {
    status = Status.loading;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    this.username = username;
    this.email = email;
    this.password = password;
    status = Status.success;
    notifyListeners();
  }

  Future<bool> registerAndLogin({
    required String name,
    required String phone,
    required String age,
    required String governorate,
  }) async {
    status = Status.loading;
    notifyListeners();

    try {
      final registerResponse = await ApiService.instance.post(
        EndPoints.auth.register,
        data: {
          "fullName": name,
          "userName": username,
          "email": email,
          "password": password,
          "governorate": governorate,
          "phoneNumber": phone,
          "age": int.parse(age),
        },
      );
      final registerAuthModel = AuthModel.fromJson(registerResponse);
      // Check if the user is registered
      if (registerAuthModel.isAuthenticated == true) {
        // Login the user
        final loginResponse = await ApiService.instance.post(
          EndPoints.auth.login,
          data: {"email": email, "password": password},
        );
        final loginAuthModel = AuthModel.fromJson(loginResponse);
        // check if the user is logged in
        if (loginAuthModel.isAuthenticated == true) {
          SecureStorage.instance.saveTokens(
            loginAuthModel.token,
            loginAuthModel.refreshToken,
            loginAuthModel.refreshTokenExpiration,
          );
          status = Status.success;
          notifyListeners();
          return true;
        }
      }
      // if the user is not registered or not logged in
      status = Status.error;
      notifyListeners();
      return false;
    } on ServerException catch (e) {
      // server error
      errorMessage = e.message;
      status = Status.error;
      notifyListeners();
      return false;
    } catch (e) {
      // unknown error
      errorMessage = "حدث خطأ ما";
      status = Status.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateUserInfo({
    required String name,
    required String phone,
    required String age,
    required String governorate,
  }) async {
    status = Status.loading;
    notifyListeners();

    try {
      final updateProfileResponse = await ApiService.instance.put(
        EndPoints.auth.updateProfile,
        data: {
          "fullName": name,
          "governorate": governorate,
          "phoneNumber": phone,
          "age": int.parse(age),
        },
      );
      final updateProfileAuthModel = AuthModel.fromJson(updateProfileResponse);
      // Check if the user is updated
      if (updateProfileAuthModel.isAuthenticated == true) {
        status = Status.success;
        notifyListeners();
        return true;
      }
      // if the user is not updated
      status = Status.error;
      notifyListeners();
      return false;
    } on ServerException catch (e) {
      // server error
      errorMessage = e.message;
      status = Status.error;
      notifyListeners();
      return false;
    } catch (e) {
      // unknown error
      errorMessage = "حدث خطأ ما";
      status = Status.error;
      notifyListeners();
      return false;
    }
  }
}
