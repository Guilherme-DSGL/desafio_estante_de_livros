import '../entities/book_entity.dart';

abstract interface class IBookRepository {
  Future<List<BookEntity>> getBooks();
  Future<void> favoriteBook({required BookEntity bookEntity});
  Future<void> unFavoriteBook({required BookEntity bookEntity});
  Future<List<BookEntity>> getFavoritesBooks();
}
