class AuthModel {
  final bool isAuthenticated;
  final String userName;
  final String email;
  final bool isNewUser;
  final String token;
  final String expiresOn;
  final String refreshToken;
  final String refreshTokenExpiration;

  AuthModel({
    required this.isAuthenticated,
    required this.userName,
    required this.email,
    required this.isNewUser,
    required this.token,
    required this.expiresOn,
    required this.refreshToken,
    required this.refreshTokenExpiration,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
    isAuthenticated: json['isAuthenticated'],
    userName: json['userName'],
    email: json['email'],
    isNewUser: json['isNewUser'],
    token: json['token'],
    expiresOn: json['expiresOn'],
    refreshToken: json['refreshToken'] ?? "",
    refreshTokenExpiration: json['refreshTokenExpiration'],
  );
}
