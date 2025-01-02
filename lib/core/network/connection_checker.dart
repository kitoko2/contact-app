import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/// [ConnectionChecker] is an interface for checking internet connection
abstract interface class ConnectionChecker {
  Future<bool> get isConnected;
}

/// [ConnectionCheckerImpl] is an implementation of [ConnectionChecker]
class ConnectionCheckerImpl implements ConnectionChecker {
  final InternetConnection internetConnection;
  ConnectionCheckerImpl(this.internetConnection);

  /// check internet connection
  @override
  Future<bool> get isConnected async =>
      await internetConnection.hasInternetAccess;
}
