import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taffi/core/constants/api_config.dart';
import 'package:taffi/core/constants/app_constants.dart';
import 'package:taffi/core/data/local/secure_storage.dart';
import 'package:taffi/core/data/remote/api_service.dart';
import 'package:taffi/core/data/remote/server_exception.dart';

class LoginProvider extends ChangeNotifier {
  bool isLoading = false;

  String? errorMessage;

  final ApiService _apiService = ApiService.instance;

  Future<bool> loginByEmailAndPassword({
    required String email,
    required String password,
    required bool saveInfo,
  }) async {
    isLoading = true;
    notifyListeners();
    try {
      // Login By Email And Password
      final response = await _apiService.post(
        EndPoints.auth.login,
        data: {"email": email, "password": password},
      );

      // Check If The User Is Authenticated (Email And Password Are Correct)
      if (response["isAuthenticated"] == true) {
        // Save Tokens
        await SecureStorage.instance.saveTokens(
          response[AppConstants.accessToken],
          response[AppConstants.refreshToken],
        );
        // Stop Loading
        isLoading = false;
        notifyListeners();
        return true;
      }
      // User Not Authenticated (Email Or Password Is Incorrect)
      isLoading = false;
      notifyListeners();
      return false;
    } on ServerException catch (e) {
      // Server Exception
      errorMessage = e.message;
      isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      // Unknown Exception
      errorMessage = "حدث خطأ ما";
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> loginWithGoogle() async {
    isLoading = true;
    notifyListeners();
    try {
      final GoogleSignInAccount? account = await GoogleSignIn(
        serverClientId: "348555858270-65hnv3via7u527lq5tiv59qn6qh3juhe.apps.googleusercontent.com",
        scopes: ["email", 'profile'],
      ).signIn();

      if (account != null) {
        final GoogleSignInAuthentication authentication = await account.authentication;
        final String idToken = authentication.idToken!;

        // Login With Google
        final response = await _apiService.post(
          EndPoints.auth.googleLogin,
          data: {"idToken": idToken},
        );

        // Check If The User Is Authenticated
        if (response["isAuthenticated"] == true) {
          // Save Tokens
          await SecureStorage.instance.saveTokens(
            response[AppConstants.accessToken],
            response[AppConstants.refreshToken],
          );
          // Stop Loading
          isLoading = false;
          notifyListeners();
          return true;
        }
      }
      // User Not Authenticated
      isLoading = false;
      notifyListeners();
      return false;
    } on ServerException catch (e) {
      // Server Exception
      errorMessage = e.message;
      isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      // Unknown Exception
      errorMessage = "حدث خطأ ما";
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
