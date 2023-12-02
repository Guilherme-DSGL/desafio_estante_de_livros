import '../../entities/book_entity.dart';

abstract interface class IFavoriteBookUsecase {
  Future<void> call({required BookEntity bookEntity});
}
