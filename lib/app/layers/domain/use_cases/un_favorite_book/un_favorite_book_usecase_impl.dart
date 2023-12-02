import '../../entities/book_entity.dart';
import '../../repositories/book_repository_interface.dart';
import 'un_favorite_book_usecase_interface.dart';

class UnFavoriteBookUseCaseImpl implements IUnFavoriteBookUsecase {
  final IBookRepository _bookRepository;
  UnFavoriteBookUseCaseImpl({required IBookRepository bookRepository})
      : _bookRepository = bookRepository;
  @override
  Future<void> call({required BookEntity bookEntity}) async {
    return await _bookRepository.unFavoriteBook(bookEntity: bookEntity);
  }
}
