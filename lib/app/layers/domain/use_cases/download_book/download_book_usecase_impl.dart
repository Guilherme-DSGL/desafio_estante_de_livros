import 'dart:io';

import 'package:desafio_estante_de_livros/app/layers/domain/repositories/book_repository_interface.dart';

import 'download_book_usecase_interface.dart';

class DownloadBookUsecaseImpl implements IDownloadBookUsecase {
  final IBookRepository _bookRepository;
  DownloadBookUsecaseImpl({
    required IBookRepository bookrepository,
  }) : _bookRepository = bookrepository;

  @override
  Future<void> call({
    required String downloadUrl,
    required String pathDirectory,
  }) async {
    File file = File(pathDirectory);
    try {
      await file.create();
      await _bookRepository.downloadBook(
          downloadUrl: downloadUrl, pathDirectory: pathDirectory);
    } catch (e) {
      if (file.existsSync()) {
        file.deleteSync();
      }
      rethrow;
    }
  }
}
