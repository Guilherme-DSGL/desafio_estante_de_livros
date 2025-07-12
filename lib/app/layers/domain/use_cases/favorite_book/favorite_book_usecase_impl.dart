import '../../entities/book_entity.dart';
import '../../repositories/book_repository_interface.dart';
import 'favorite_book_usecase_interface.dart';

class FavoriteBookUseCaseImpl implements IFavoriteBookUsecase {
  FavoriteBookUseCaseImpl({required IBookRepository bookRepository})
      : _bookRepository = bookRepository;

  final IBookRepository _bookRepository;

  @override
  Future<BookEntity> call({required BookEntity bookEntity}) async =>
      _bookRepository.favoriteBook(bookEntity: bookEntity);
}
