/// [T] type of database
abstract interface class ILocalDBProvider<T> {
  Future<T> get database;
}
