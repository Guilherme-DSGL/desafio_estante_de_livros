import 'package:http/http.dart' as http;

import 'http_client_adapter_interface.dart';

const kApiUrl = 'http://numbersapi.com';

class HttpClientAdapter implements IHttpClientAdapter<http.Response> {
  @override
  Future<http.Response> get(String path, {Map<String, String>? headers}) async {
    final url = Uri.parse(path);
    final res = await http.get(url, headers: headers);
    return res;
  }
}
