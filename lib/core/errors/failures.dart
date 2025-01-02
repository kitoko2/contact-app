import 'package:equatable/equatable.dart';

/// Abstract class representing a Failure in the application
abstract class Failure extends Equatable {
  /// Message describing the failure
  final String message;

  /// Constructor for Failure
  const Failure({required this.message});

  @override
  List<Object> get props => [message];
}

/// Represents a failure that occurred due to a server error
class ServerFailure extends Failure {
  /// Constructor for ServerFailure
  const ServerFailure({super.message = 'A server error occurred'});
}

/// Represents a failure that occurred due to a network error
class NetworkFailure extends Failure {
  /// Constructor for NetworkFailure
  const NetworkFailure({super.message = 'A network error occurred'});
}

/// Represents a failure that occurred due to a timeout error
class TimeoutFailure extends Failure {
  /// Constructor for TimeoutFailure
  const TimeoutFailure({super.message = 'A timeout error occurred'});
}

/// Represents a failure when unknow error
class UnknownFailure extends Failure {
  /// Constructor for AuthorizationFailure
  const UnknownFailure({super.message = 'UnknownFailure occurred'});
}

/// Represents a failure that occurred due to an authorization error
class CacheFailure extends Failure {
  /// Constructor for AuthorizationFailure
  const CacheFailure({super.message = 'CacheFailure error occurred'});
}
