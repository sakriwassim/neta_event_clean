import 'package:flutter/widgets.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConncted;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);
  @override
  // TODO: implement isConncted
  Future<bool> get isConncted => connectionChecker.hasConnection;
}
