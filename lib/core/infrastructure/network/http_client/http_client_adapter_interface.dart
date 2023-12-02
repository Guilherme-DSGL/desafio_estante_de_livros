abstract interface class IHttpClientAdapter<T> {
  Future<T> get(String path, {Map<String, String>? headers});
}
