import 'package:sqflite/sqflite.dart';

import '../../../../app/layers/data/dtos/book_dto.dart';
import '../../../errors/exceptions.dart';

class BookService {
  BookService._();

  static Future<void> insertBook({
    required BookDTO bookDTO,
    required Database database,
  }) async {
    try {
      await database.insert(
        'books',
        bookDTO.toSQLMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (_) {
      throw LocalDBException();
    }
  }

  static Future<List<BookDTO>> getAllBooks({required Database database}) async {
    final List<Map<String, dynamic>> maps = await database.query('books');
    return List.generate(
      maps.length,
      (index) {
        return BookDTO.fromSQLMap(maps[index]);
      },
    ).reversed.toList();
  }

  static Future<void> deleteBook({
    required int bookId,
    required Database database,
  }) async {
    try {
      await database.delete(
        'books',
        where: 'id = ?',
        whereArgs: [bookId],
      );
    } catch (_) {
      throw LocalDBException();
    }
  }
}
