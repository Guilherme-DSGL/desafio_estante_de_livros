import '../../entities/book_entity.dart';
import '../../repositories/book_repository_interface.dart';
import 'get_books_usecase_interface.dart';

class GetBooksUseCaseImpl implements IGetBooksUsecase {
  GetBooksUseCaseImpl({
    required IBookRepository bookRepository,
  }) : _bookRepository = bookRepository;

  final IBookRepository _bookRepository;

  @override
  Future<List<BookEntity>> call({int page = 1}) async =>
      _bookRepository.getBooks(page: page);
}
