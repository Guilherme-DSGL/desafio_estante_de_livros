import 'package:dio/dio.dart';

import '../../../errors/exceptions.dart';
import 'http_client_adapter_interface.dart';

class HttpClientAdapterImpl implements IHttpClientAdapter {
  @override
  Future<T> get<T>(String path) async {
    final dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    final Response<T> res = await dio.get<T>(path);
    if (res.statusCode == 200) {
      return res.data!;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> download({
    required String downloadUrl,
    required String pathDirectory,
    void Function()? onComplete,
    void Function()? onError,
  }) async {
    final dio = Dio();
    await dio
        .download(
      downloadUrl,
      pathDirectory,
    )
        .then((value) {
      onComplete?.call();
    }).catchError((error, stackTrace) {
      onError?.call();
    });
  }
}
