import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkChecker {

  static Future<bool> hasInternet() async {

    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }

    return true;
  }

}
