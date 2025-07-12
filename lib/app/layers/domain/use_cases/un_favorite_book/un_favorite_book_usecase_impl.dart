import '../../entities/book_entity.dart';
import '../../repositories/book_repository_interface.dart';
import 'un_favorite_book_usecase_interface.dart';

class UnFavoriteBookUseCaseImpl implements IUnFavoriteBookUsecase {
  UnFavoriteBookUseCaseImpl({required IBookRepository bookRepository})
      : _bookRepository = bookRepository;
  final IBookRepository _bookRepository;
  @override
  Future<BookEntity> call({required BookEntity bookEntity}) async =>
      _bookRepository.unFavoriteBook(bookEntity: bookEntity);
}
