import '../../domain/entities/book_entity.dart';

abstract interface class ILocalBookDataSource {
  Future<BookEntity> favoriteBook({required BookEntity bookEntity});
  Future<BookEntity> unfavoriteBook({required BookEntity bookEntity});
  Future<List<BookEntity>> getBooksFavorite();
}

abstract interface class IRemoteBookDataSource {
  Future<List<BookEntity>> getBooks();
}
