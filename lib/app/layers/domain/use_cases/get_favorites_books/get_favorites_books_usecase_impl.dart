import '../../entities/book_entity.dart';
import '../../repositories/book_repository_interface.dart';
import 'get_favorites_books_usecase_interface.dart';

class GetFavoritesBooksUseCaseImpl implements IGetFavoritesBooksUsecase {
  GetFavoritesBooksUseCaseImpl({required IBookRepository bookRepository})
      : _bookRepository = bookRepository;

  final IBookRepository _bookRepository;

  @override
  Future<List<BookEntity>> call() => _bookRepository.getFavoritesBooks();
}
