import '../../entities/book_entity.dart';
import '../../repositories/book_repository_interface.dart';
import 'get_books_usecase_interface.dart';

class GetBooksUseCaseImpl implements IGetBooksUsecase {
  final IBookRepository _bookRepository;
  GetBooksUseCaseImpl(IBookRepository bookRepository)
      : _bookRepository = bookRepository;
  @override
  Future<List<BookEntity>> call() async {
    return await _bookRepository.getBooks();
  }
}
