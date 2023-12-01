import '../../entities/book_entity.dart';

abstract interface class IGetFavoritesBooksUsecase {
  Future<List<BookEntity>> call();
}
