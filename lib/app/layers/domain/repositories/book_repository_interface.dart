import '../entities/book_entity.dart';

abstract interface class IBookRepository {
  Future<List<BookEntity>> getBooks();
  Future<void> favoriteBook({required int idBook});
  Future<void> unFavoriteBook({required int idBook});
  Future<List<BookEntity>> getFavoritesBooks();
}
