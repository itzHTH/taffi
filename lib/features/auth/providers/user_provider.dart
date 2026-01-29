import 'package:flutter/material.dart';
import 'package:taffi/core/constants/api_config.dart';
import 'package:taffi/core/data/local/secure_storage.dart';
import 'package:taffi/core/data/remote/api_service.dart';
import 'package:taffi/core/data/remote/server_exception.dart';
import 'package:taffi/core/enums/status_enum.dart';
import 'package:taffi/features/auth/models/auth_model.dart';
import 'package:taffi/features/auth/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? user;

  Status loadUserStatus = Status.initial;
  Status updateUserStatus = Status.initial;
  String errorMessage = '';

  Future<void> getUserInfo() async {
    try {
      loadUserStatus = Status.loading;
      notifyListeners();

      final response = await ApiService.instance.get(EndPoints.auth.profile);
      user = UserModel.fromJson(response);

      loadUserStatus = Status.success;
      notifyListeners();
    } on ServerException catch (e) {
      loadUserStatus = Status.error;
      errorMessage = e.message ?? 'حصل خطا ما';
      notifyListeners();
    } catch (e) {
      loadUserStatus = Status.error;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<bool> updateUserInfo({
    required String fullname,
    required String phone,
    required String age,
    required String governorate,
  }) async {
    updateUserStatus = Status.loading;
    notifyListeners();

    try {
      final updateProfileResponse = await ApiService.instance.put(
        EndPoints.auth.updateProfile,
        data: {
          "fullName": fullname,
          "governorate": governorate,
          "phoneNumber": phone,
          "age": int.parse(age),
        },
      );
      final updateProfileAuthModel = AuthModel.fromJson(updateProfileResponse);
      // Check if the user is updated
      if (updateProfileAuthModel.isAuthenticated == true) {
        SecureStorage.instance.saveTokens(
          updateProfileAuthModel.token,
          updateProfileAuthModel.refreshToken,
          updateProfileAuthModel.refreshTokenExpiration,
        );
        updateUserStatus = Status.success;
        notifyListeners();
        return true;
      }
      // if the user is not updated
      updateUserStatus = Status.error;
      notifyListeners();
      return false;
    } on ServerException catch (e) {
      // server error
      errorMessage = e.message ?? "حدث خطأ في السيرفر";
      updateUserStatus = Status.error;
      notifyListeners();
      return false;
    } catch (e) {
      // unknown error
      errorMessage = "حدث خطأ ما";
      updateUserStatus = Status.error;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    loadUserStatus = Status.loading;
    notifyListeners();

    try {
      await SecureStorage.instance.deleteTokens();
      loadUserStatus = Status.success;
      notifyListeners();
    } catch (e) {
      loadUserStatus = Status.error;
      errorMessage = e.toString();
      notifyListeners();
    }
  }
}
