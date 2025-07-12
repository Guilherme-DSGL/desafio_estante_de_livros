import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

abstract class FileHelper {
  FileHelper._();
  static String getFileNameFromURL(String url) {
    final Uri uri = Uri.parse(url);
    final String fileName = path.basenameWithoutExtension(uri.path);
    return fileName;
  }

  static Future<String> createPathToDownload(String url) async {
    final Directory? appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    final String fileName = getFileNameFromURL(url);
    final path = '${appDocDir!.path}/$fileName.epub';

    return path;
  }

  static bool existFile(String path) {
    return File(path).existsSync();
  }
}
