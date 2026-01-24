import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taffi/core/constants/api_config.dart';
import 'package:taffi/core/data/local/secure_storage.dart';
import 'package:taffi/core/data/remote/api_service.dart';
import 'package:taffi/core/data/remote/server_exception.dart';
import 'package:taffi/core/enums/status_enum.dart';
import 'package:taffi/core/routing/route_names.dart';
import 'package:taffi/core/services/navigation_service.dart';
import 'package:taffi/features/auth/models/auth_model.dart';

class LoginProvider extends ChangeNotifier {
  Status status = Status.initial;

  String? errorMessage;

  final ApiService _apiService = ApiService.instance;

  Future<bool> loginByEmailAndPassword({
    required String email,
    required String password,
    required bool saveInfo,
  }) async {
    status = Status.loading;
    notifyListeners();
    try {
      // Login By Email And Password
      final response = await _apiService.post(
        EndPoints.auth.login,
        data: {"email": email, "password": password},
      );

      final authModel = AuthModel.fromJson(response);

      // Check If The User Is Authenticated (Email And Password Are Correct)
      if (authModel.isAuthenticated == true) {
        // Save Tokens
        await SecureStorage.instance.saveTokens(
          authModel.token,
          authModel.refreshToken,
          authModel.refreshTokenExpiration,
        );
        // Stop Loading
        status = Status.success;
        notifyListeners();
        return true;
      }
      // User Not Authenticated (Email Or Password Is Incorrect)
      status = Status.error;
      notifyListeners();
      return false;
    } on ServerException catch (e) {
      // Server Exception
      errorMessage = e.message;
      status = Status.error;
      notifyListeners();
      return false;
    } catch (e) {
      // Unknown Exception
      errorMessage = "حدث خطأ ما";
      status = Status.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> loginWithGoogle() async {
    status = Status.loading;
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

        final authModel = AuthModel.fromJson(response);

        // Check If The User Is Authenticated
        if (authModel.isAuthenticated == true) {
          // Save Tokens
          await SecureStorage.instance.saveTokens(
            authModel.token,
            authModel.refreshToken,
            authModel.refreshTokenExpiration,
          );

          // Check If The User Is New User
          if (authModel.isNewUser == true) {
            NavigationService().pushNamedAndRemoveUntil(
              RouteNames.fillPersonalInfo,
              arguments: {'isFromGoogle': true},
            );

            status = Status.initial;
            notifyListeners();
            return false; // Navigate To Fill Personal Info Page
          }

          // Stop Loading
          status = Status.success;
          notifyListeners();
          return true;
        }
      }
      // User Not Authenticated
      status = Status.error;
      notifyListeners();
      return false;
    } on ServerException catch (e) {
      // Server Exception
      errorMessage = e.message;
      status = Status.error;
      notifyListeners();
      return false;
    } catch (e) {
      // Unknown Exception
      errorMessage = "حدث خطأ ما";
      status = Status.error;
      notifyListeners();
      return false;
    }
  }
}
