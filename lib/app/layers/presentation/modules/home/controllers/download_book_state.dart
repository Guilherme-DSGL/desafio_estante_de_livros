part of 'download_book_controller.dart';

enum DownloadBookStatus { initial, loading, loaded, failure }

class DownloadBookState extends Equatable {
  const DownloadBookState._({
    required this.status,
    required this.booksInDownload,
    this.errorMessage,
  });

  const DownloadBookState.initial()
      : this._(
          booksInDownload: const {},
          status: DownloadBookStatus.initial,
        );

  final DownloadBookStatus status;
  final Set<BookEntity> booksInDownload;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, errorMessage, booksInDownload];

  DownloadBookState copyWith({
    DownloadBookStatus? status,
    Set<BookEntity>? booksInDownload,
    String? errorMessage,
  }) =>
      DownloadBookState._(
        status: status ?? this.status,
        booksInDownload: booksInDownload ?? this.booksInDownload,
        errorMessage: errorMessage,
      );
}
