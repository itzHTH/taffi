class ServerException implements Exception {
  final String? message;
  final int? statusCode;
  final dynamic data;

  ServerException({required this.message, this.statusCode, this.data});
}
