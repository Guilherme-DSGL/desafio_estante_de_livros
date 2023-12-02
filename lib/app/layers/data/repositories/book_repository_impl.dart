import '../../domain/entities/book_entity.dart';
import '../../domain/repositories/book_repository_interface.dart';
import '../datasources/remote_book_datasource_interfaces.dart';

class BookRepositoryImpl implements IBookRepository {
  final IRemoteBookDataSource _remoteBookRepository;
  final ILocalBookDataSource _localBookRepository;

  BookRepositoryImpl(
      {required IRemoteBookDataSource remoteBookRepository,
      required ILocalBookDataSource localBookDataSource})
      : _remoteBookRepository = remoteBookRepository,
        _localBookRepository = localBookDataSource;

  @override
  Future<BookEntity> favoriteBook({required BookEntity bookEntity}) {
    return _localBookRepository.favoriteBook(bookEntity: bookEntity);
  }

  @override
  Future<BookEntity> unFavoriteBook({required BookEntity bookEntity}) {
    return _localBookRepository.unfavoriteBook(bookEntity: bookEntity);
  }

  @override
  Future<List<BookEntity>> getBooks() {
    return _remoteBookRepository.getBooks();
  }

  @override
  Future<List<BookEntity>> getFavoritesBooks() {
    return _localBookRepository.getBooksFavorite();
  }
}
