import 'package:internet_connection_checker/internet_connection_checker.dart';

/// interface that have a weak dependency with class QuoteRepositoryImpl();
/// Dependency injection
/// if internet_connection_checker package deprecated or changed
/// then i will refactor this class only

/// <<NetworkInfo Class is injected in QuoteRepositoryImpl Class>>

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl({required this.connectionChecker});
  @override
  Future<bool> get isConnected async =>
      await InternetConnectionChecker().hasConnection;
}
