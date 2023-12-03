import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

abstract class FileHelper {
  FileHelper._();
  static String getFileNameFromURL(String url) {
    Uri uri = Uri.parse(url);
    String fileName = path.basenameWithoutExtension(uri.path);
    return fileName;
  }

  static Future<String> createPathToDownload(String url) async {
    Directory? appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    String fileName = getFileNameFromURL(url);
    String path = '${appDocDir!.path}/$fileName.epub';

    return path;
  }

  static bool existFile(String path) {
    return File(path).existsSync();
  }
}
