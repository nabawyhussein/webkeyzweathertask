class Failure {
  final String message;
  final Exception? exception;
  final StackTrace? stackTrace;

  Failure(
    this.message, [
    this.exception,
    this.stackTrace,
  ]);

  @override
  String toString() {
    return "Failure (${exception == null ? 'No ' : ''}Exception): $message";
  }
}

class ServerException implements Exception {
  final String message;

  ServerException({
    required this.message,
  });
}

class CacheException implements Exception {
  final dynamic message;

  CacheException(this.message);
}
