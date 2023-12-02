import 'package:desafio_estante_de_livros/app/layers/domain/entities/book_entity.dart';

abstract interface class ILocalBookDataSource {
  Future<void> favoriteBook({required BookEntity bookEntity});
  Future<void> unfavoriteBook({required BookEntity bookEntity});
  Future<List<BookEntity>> getBooksFavorite();
}

abstract interface class IRemoteBookDataSource {
  Future<List<BookEntity>> getBooks();
}