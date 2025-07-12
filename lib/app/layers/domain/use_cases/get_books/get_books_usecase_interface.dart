import '../../entities/book_entity.dart';

abstract interface class IGetBooksUsecase {
  Future<List<BookEntity>> call({int page});
}
