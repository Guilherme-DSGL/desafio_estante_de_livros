import 'package:sqflite/sqflite.dart';

import '../../../../../core/infrastructure/local_db/local_db_interface.dart';
import '../../../../../core/infrastructure/local_db/services/book_service.dart';
import '../../../domain/entities/book_entity.dart';
import '../../dtos/book_dto.dart';
import '../remote_book_datasource_interfaces.dart';

class LocalBookDataSource implements ILocalBookDataSource {
  final ILocalDBProvider<Database> _localDBProvider;
  LocalBookDataSource({
    required ILocalDBProvider<Database> localDBProvider,
  }) : _localDBProvider = localDBProvider;

  @override
  Future<void> favoriteBook({required BookEntity bookEntity}) async {
    await BookService.insertBook(
      bookDTO: BookDTO.fromEntity(bookEntity),
      database: await _localDBProvider.database,
    );
  }

  @override
  Future<List<BookEntity>> getBooksFavorite() async {
    return await BookService.getAllBooks(
      database: await _localDBProvider.database,
    );
  }

  @override
  Future<void> unfavoriteBook({required BookEntity bookEntity}) async {
    await BookService.insertBook(
        bookDTO: BookDTO.fromEntity(bookEntity),
        database: await _localDBProvider.database);
  }
}
