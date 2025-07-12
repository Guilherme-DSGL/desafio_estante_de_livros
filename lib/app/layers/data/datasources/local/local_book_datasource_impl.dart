import 'package:sqflite/sqflite.dart';

import '../../../../../core/infrastructure/local_db/local_db_interface.dart';
import '../../../../../core/infrastructure/local_db/services/book_service.dart';
import '../../../domain/entities/book_entity.dart';
import '../../dtos/book_dto.dart';
import '../remote_book_datasource_interfaces.dart';

class LocalBookDataSource implements ILocalBookDataSource {
  LocalBookDataSource({
    required ILocalDBProvider<Database> localDBProvider,
  }) : _localDBProvider = localDBProvider;
  final ILocalDBProvider<Database> _localDBProvider;

  @override
  Future<BookEntity> favoriteBook({required BookEntity bookEntity}) async {
    final BookDTO book =
        BookDTO.fromEntity(bookEntity).copyWith(isFavorite: true);
    await BookService.insertBook(
      bookDTO: book,
      database: await _localDBProvider.database,
    );
    return book;
  }

  @override
  Future<List<BookEntity>> getBooksFavorite() async => BookService.getAllBooks(
        database: await _localDBProvider.database,
      );

  @override
  Future<BookEntity> unfavoriteBook({required BookEntity bookEntity}) async {
    final BookDTO book =
        BookDTO.fromEntity(bookEntity).copyWith(isFavorite: false);
    await BookService.deleteBook(
      bookId: bookEntity.id,
      database: await _localDBProvider.database,
    );
    return book;
  }
}
