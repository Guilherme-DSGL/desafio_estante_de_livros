import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'local_db_interface.dart';

class LocalDBProviderImpl implements ILocalDBProvider<Database> {
  LocalDBProviderImpl._();

  static ILocalDBProvider get instance => LocalDBProviderImpl._();

  Database? _database;

  @override
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    return openDatabase(
      join(path, 'database.db'),
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
        CREATE TABLE books (
          id INTEGER PRIMARY KEY,
          title TEXT,
          author TEXT,
          coverUrl TEXT,
          downloadUrl TEXT,
          isFavorite INTEGER
        );
      ''');
  }
}
