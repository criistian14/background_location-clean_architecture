import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkInfo {
  /// Get the value if connected to the internet
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
