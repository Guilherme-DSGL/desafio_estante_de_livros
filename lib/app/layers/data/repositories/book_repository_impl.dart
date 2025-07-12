import '../../domain/entities/book_entity.dart';
import '../../domain/repositories/book_repository_interface.dart';
import '../datasources/remote_book_datasource_interfaces.dart';

class BookRepositoryImpl implements IBookRepository {
  BookRepositoryImpl({
    required IRemoteBookDataSource remoteBookRepository,
    required ILocalBookDataSource localBookDataSource,
  })  : _remoteBookRepository = remoteBookRepository,
        _localBookRepository = localBookDataSource;

  final IRemoteBookDataSource _remoteBookRepository;
  final ILocalBookDataSource _localBookRepository;

  @override
  Future<BookEntity> favoriteBook({required BookEntity bookEntity}) =>
      _localBookRepository.favoriteBook(bookEntity: bookEntity);

  @override
  Future<BookEntity> unFavoriteBook({required BookEntity bookEntity}) =>
      _localBookRepository.unfavoriteBook(bookEntity: bookEntity);

  @override
  Future<List<BookEntity>> getBooks({required int page}) =>
      _remoteBookRepository.getBooks(page: page);

  @override
  Future<List<BookEntity>> getFavoritesBooks() =>
      _localBookRepository.getBooksFavorite();

  @override
  Future<void> downloadBook({
    required String downloadUrl,
    required String pathDirectory,
  }) async {
    await _remoteBookRepository.downloadBook(
      downloadUrl: downloadUrl,
      pathDirectory: pathDirectory,
    );
  }
}
