import 'package:flutter/services.dart';

abstract class AndroidVersionHelper {
  AndroidVersionHelper._();
  static Future<String> getVersion() async {
    const platform = MethodChannel('my_channel');
    final String version = await platform.invokeMethod('getAndroidVersion');
    return version;
  }

  static Future<int> getVersionNumber() async {
    final String version = await getVersion();
    String? firstPart;
    if (version.toString().contains(".")) {
      int indexOfFirstDot = version.indexOf(".");
      firstPart = version.substring(0, indexOfFirstDot);
    } else {
      firstPart = version;
    }
    return int.parse(firstPart);
  }
}
