import '../../entities/book_entity.dart';

abstract interface class IUnFavoriteBookUsecase {
  Future<BookEntity> call({required BookEntity bookEntity});
}
