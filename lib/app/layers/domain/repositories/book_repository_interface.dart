import '../entities/book_entity.dart';

abstract interface class IBookRepository {
  Future<List<BookEntity>> getBooks();
  Future<void> favoriteBook({int idBook});
  Future<void> unFavoriteBook({int idBook});
  Future<List<BookEntity>> getFavoritesBooks();
}
