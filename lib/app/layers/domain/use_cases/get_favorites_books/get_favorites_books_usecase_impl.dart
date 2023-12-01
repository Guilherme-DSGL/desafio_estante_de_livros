import '../../entities/book_entity.dart';

import '../../repositories/book_repository_interface.dart';
import 'get_favorites_books_usecase_interface.dart';

class GetFavoritesBooksUseCaseImpl implements IGetFavoritesBooksUsecase {
  final IBookRepository _bookRepository;
  GetFavoritesBooksUseCaseImpl({required IBookRepository bookRepository})
      : _bookRepository = bookRepository;
  @override
  Future<List<BookEntity>> call() async {
    return await _bookRepository.getFavoritesBooks();
  }
}
