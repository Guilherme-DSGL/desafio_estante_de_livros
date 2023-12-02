import '../../entities/book_entity.dart';

abstract interface class IFavoriteBookUsecase {
  Future<BookEntity> call({required BookEntity bookEntity});
}
