import 'package:connectivity_plus/connectivity_plus.dart';

verifyConnectivity() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  return connectivityResult;
}
