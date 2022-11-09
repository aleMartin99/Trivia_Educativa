import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:trivia_educativa/core/network_info/network_info.dart';

class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl(this.connectionChecker);

  final InternetConnectionChecker connectionChecker;

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
