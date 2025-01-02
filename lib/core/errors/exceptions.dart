/// Exception thrown when a server error occurs
class ServerException implements Exception {
  final String message;

  final Object error;
  final int? statusCode;

  ServerException(this.error,
      {this.message = 'A server error occurred', this.statusCode});

  @override
  String toString() => 'ServerException: $message';
}

class TimeoutException implements Exception {
  final String message;

  TimeoutException({this.message = 'Request timeout occurred'});

  @override
  String toString() => 'TimeoutException: $message';
}

/// Exception thrown when a network error occurs
class NetworkException implements Exception {
  final String message;

  NetworkException({this.message = 'A network error occurred'});

  @override
  String toString() => 'NetworkException: $message';
}

class UnknownException implements Exception {
  final String message;

  UnknownException({this.message = 'An unknown error occurred'});

  @override
  String toString() => 'UnknownException: $message';
}
