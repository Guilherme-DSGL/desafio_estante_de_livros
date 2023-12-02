import '../../entities/book_entity.dart';

abstract interface class IUnFavoriteBookUsecase {
  Future<void> call({required BookEntity bookEntity});
}
