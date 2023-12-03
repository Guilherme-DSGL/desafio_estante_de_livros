abstract interface class IHttpClientAdapter {
  Future<T> get<T>(String path);
  Future<void> download(
      {required String downloadUrl,
      required String pathDirectory,
      void Function()? onComplete,
      void Function()? onError});
}
