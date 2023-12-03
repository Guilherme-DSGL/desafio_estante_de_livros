abstract interface class IDownloadBookUsecase {
  Future<void> call({
    required String downloadUrl,
    required String pathDirectory,
  });
}
