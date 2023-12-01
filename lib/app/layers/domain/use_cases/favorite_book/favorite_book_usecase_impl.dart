import '../../entities/book_entity.dart';
import '../../repositories/book_repository_interface.dart';

import 'favorite_book_usecase_interface.dart';

class FavoriteBookUseCaseImpl implements IFavoriteBookUsecase {
  final IBookRepository _bookRepository;
  FavoriteBookUseCaseImpl(IBookRepository bookRepository)
      : _bookRepository = bookRepository;
  @override
  Future<void> call({required int idBook}) async {
    return await _bookRepository.favoriteBook(idBook: idBook);
  }
}