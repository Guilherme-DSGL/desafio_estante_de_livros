import 'package:desafio_estante_de_livros/core/infrastructure/local_db/local_db_impl.dart';
import 'package:desafio_estante_de_livros/core/infrastructure/local_db/local_db_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  group('Local Data Source', () {
    late ILocalDBProvider localDB;
    late Database db;

    setUpAll(() async {
      databaseFactory = databaseFactoryFfi;
      localDB = LocalDBProviderImpl.instance;
      sqfliteFfiInit();
      db = await localDB.database;
    });

    test('Creates tables  data successfully', () async {
      final List<Map<String, Object?>> books =
          await db.query('books', limit: 1);
      expect(books, isEmpty);
    });
  });
}
