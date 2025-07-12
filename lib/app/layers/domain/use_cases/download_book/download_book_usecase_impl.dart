import 'dart:io';

import '../../repositories/book_repository_interface.dart';
import 'download_book_usecase_interface.dart';

class DownloadBookUsecaseImpl implements IDownloadBookUsecase {
  DownloadBookUsecaseImpl({
    required IBookRepository bookrepository,
  }) : _bookRepository = bookrepository;
  final IBookRepository _bookRepository;

  @override
  Future<void> call({
    required String downloadUrl,
    required String pathDirectory,
  }) async {
    final file = File(pathDirectory);
    try {
      await file.create();
      await _bookRepository.downloadBook(
        downloadUrl: downloadUrl,
        pathDirectory: pathDirectory,
      );
    } catch (e) {
      if (file.existsSync()) {
        file.deleteSync();
      }
      rethrow;
    }
  }
}
