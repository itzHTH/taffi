class ServerError implements Exception {
  final String message;
  final int statusCode;
  final dynamic data;

  ServerError({required this.message, required this.statusCode, this.data});
}
