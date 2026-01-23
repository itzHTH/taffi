import 'package:flutter/material.dart';
import 'package:taffi/core/constants/api_config.dart';
import 'package:taffi/core/constants/app_constants.dart';
import 'package:taffi/core/data/local/secure_storage.dart';
import 'package:taffi/core/data/remote/api_service.dart';
import 'package:taffi/core/data/remote/server_exception.dart';

class RegisterProvider extends ChangeNotifier {
  String? errorMessage;
  bool isLoading = false;

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
    isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    this.username = username;
    this.email = email;
    this.password = password;
    isLoading = false;
    notifyListeners();
  }

  Future<bool> registerAndLogin({
    required String name,
    required String phone,
    required String age,
    required String governorate,
  }) async {
    isLoading = true;
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
      // Check if the user is registered
      if (registerResponse["isAuthenticated"] == true) {
        // Login the user
        final loginResponse = await ApiService.instance.post(
          EndPoints.auth.login,
          data: {"email": email, "password": password},
        );
        // check if the user is logged in
        if (loginResponse["isAuthenticated"] == true) {
          SecureStorage.instance.saveTokens(
            loginResponse[AppConstants.accessToken],
            loginResponse[AppConstants.refreshToken],
          );
          isLoading = false;
          notifyListeners();
          return true;
        }
      }
      // if the user is not registered or not logged in
      isLoading = false;
      notifyListeners();
      return false;
    } on ServerException catch (e) {
      // server error
      errorMessage = e.message;
      isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      // unknown error
      errorMessage = "حدث خطأ ما";
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
