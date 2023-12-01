import '../../repositories/book_repository_interface.dart';

import 'favorite_book_usecase_interface.dart';

class FavoriteBookUseCaseImpl implements IFavoriteBookUsecase {
  final IBookRepository _bookRepository;
  FavoriteBookUseCaseImpl({required IBookRepository bookRepository})
      : _bookRepository = bookRepository;
  @override
  Future<void> call({required int idBook}) async {
    return await _bookRepository.favoriteBook(idBook: idBook);
  }
}
