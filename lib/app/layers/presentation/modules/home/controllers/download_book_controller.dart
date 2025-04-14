import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:desafio_estante_de_livros/core/errors/messages.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../../core/helpers/android_version.dart';
import '../../../../../../core/helpers/file_helper.dart';
import '../../../../../../core/infrastructure/epub_view/epub_view_service.dart';
import '../../../../domain/entities/book_entity.dart';
import '../../../../domain/use_cases/download_book/download_book_usecase_interface.dart';

part 'download_book_state.dart';

class DownloadBookController extends Cubit<DownloadBookState> {
  final IDownloadBookUsecase _downloadBookUsecase;
  DownloadBookController({
    required IDownloadBookUsecase downloadBookUsecase,
  })  : _downloadBookUsecase = downloadBookUsecase,
        super(const DownloadBookState.initial());
  Future<void> openBook(BookEntity bookEntity) async {
    emit(state.copyWith(status: DownloadBookStatus.initial));
    String path = await FileHelper.createPathToDownload(bookEntity.downloadUrl);
    if (!FileHelper.existFile(path)) {
      try {
        await _donwload(bookEntity);
        EpubViewService.instance.openAsset(path);
      } catch (e) {
        state.booksInDownload.remove(bookEntity);
        emit(state.copyWith(
            errorMessage: ErrorMessages.downloadBookError,
            booksInDownload: state.booksInDownload,
            status: DownloadBookStatus.failure));
      }
    } else {
      EpubViewService.instance.openAsset(path);
    }
  }

  Future<bool> existFile(BookEntity bookEntity) async {
    emit(state.copyWith(status: DownloadBookStatus.loading));
    String path = await FileHelper.createPathToDownload(bookEntity.downloadUrl);
    emit(state.copyWith(status: DownloadBookStatus.loaded));
    return FileHelper.existFile(path);
  }

  Future<void> _donwload(BookEntity bookEntity) async {
    if (Platform.isIOS) {
      await _downloadIOS(bookEntity);
    } else if (Platform.isAndroid) {
      await _downloadAndroid(bookEntity);
    } else {
      emit(state.copyWith(
          errorMessage: ErrorMessages.platformNotFound,
          status: DownloadBookStatus.failure));
    }
  }

  Future<void> _downloadIOS(BookEntity bookEntity) async {
    final PermissionStatus status = await Permission.storage.request();
    if (status == PermissionStatus.granted) {
      await _fetchBook(bookEntity);
    } else {
      emit(state.copyWith(
          errorMessage: ErrorMessages.platformNotFound,
          status: DownloadBookStatus.failure));
    }
  }

  Future<void> _downloadAndroid(BookEntity bookEntity) async {
    try {
      int intValue = await AndroidVersionHelper.getVersionNumber();
      if (intValue >= 13) {
        await _fetchBook(bookEntity);
      } else {
        final PermissionStatus status = await Permission.storage.request();
        if (status == PermissionStatus.granted) {
          await _fetchBook(bookEntity);
        } else {
          emit(state.copyWith(
              errorMessage: ErrorMessages.directoryDenied,
              status: DownloadBookStatus.failure));
        }
      }
    } on PlatformException {
      emit(state.copyWith(
          errorMessage: ErrorMessages.androidVersionError,
          status: DownloadBookStatus.failure));
    }
  }

  Future<void> _fetchBook(BookEntity bookEntity) async {
    String path = await FileHelper.createPathToDownload(bookEntity.downloadUrl);
    emit(state.copyWith(
        status: DownloadBookStatus.loading,
        booksInDownload: {bookEntity, ...state.booksInDownload}));
    await _downloadBookUsecase.call(
        downloadUrl: bookEntity.downloadUrl, pathDirectory: path);
    state.booksInDownload.remove(bookEntity);
    emit(state.copyWith(
        status: DownloadBookStatus.loaded,
        booksInDownload: state.booksInDownload));
  }
}
