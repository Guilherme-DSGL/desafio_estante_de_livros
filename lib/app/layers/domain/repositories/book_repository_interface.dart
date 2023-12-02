import '../entities/book_entity.dart';

abstract interface class IBookRepository {
  Future<List<BookEntity>> getBooks();
  Future<BookEntity> favoriteBook({required BookEntity bookEntity});
  Future<BookEntity> unFavoriteBook({required BookEntity bookEntity});
  Future<List<BookEntity>> getFavoritesBooks();
}
