import '../../repositories/book_repository_interface.dart';
import 'un_favorite_book_usecase_interface.dart';

class UnFavoriteBookUseCaseImpl implements IUnFavoriteBookUsecase {
  final IBookRepository _bookRepository;
  UnFavoriteBookUseCaseImpl(IBookRepository bookRepository)
      : _bookRepository = bookRepository;
  @override
  Future<void> call({required int idBook}) async {
    return await _bookRepository.unFavoriteBook(idBook: idBook);
  }
}
