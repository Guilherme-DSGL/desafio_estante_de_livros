import '../../../data/datasources/local/local_book_datasource_impl.dart';
import '../../../data/datasources/remote_book_datasource_interfaces.dart';
import '../../../data/repositories/book_repository_impl.dart';
import '../../../domain/repositories/book_repository_interface.dart';
import '../../../domain/use_cases/favorite_book/favorite_book_usecase_impl.dart';
import '../../../domain/use_cases/favorite_book/favorite_book_usecase_interface.dart';
import '../../../domain/use_cases/get_books/get_books_usecase_impl.dart';
import '../../../domain/use_cases/get_books/get_books_usecase_interface.dart';
import '../../../domain/use_cases/get_favorites_books/get_favorites_books_usecase_impl.dart';
import '../../../domain/use_cases/get_favorites_books/get_favorites_books_usecase_interface.dart';
import '../../../domain/use_cases/un_favorite_book/un_favorite_book_usecase_impl.dart';
import '../../../domain/use_cases/un_favorite_book/un_favorite_book_usecase_interface.dart';
import '../../../../../core/infrastructure/local_db/local_db_impl.dart';
import '../../../../../core/infrastructure/local_db/local_db_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'pages/home_page.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton<ILocalDBProvider>((i) => LocalDBProviderImpl.instance),
        Bind.lazySingleton<ILocalBookDataSource>(
          (i) => LocalBookDataSource(localDBProvider: i()),
        ),
        Bind.lazySingleton<IBookRepository>(
          (i) => BookRepositoryImpl(
              localBookDataSource: i(), remoteBookRepository: i()),
        ),
        Bind.lazySingleton<IGetBooksUsecase>(
            (i) => GetBooksUseCaseImpl(bookRepository: i())),
        Bind.lazySingleton<IGetFavoritesBooksUsecase>(
            (i) => GetFavoritesBooksUseCaseImpl(bookRepository: i())),
        Bind.lazySingleton<IFavoriteBookUsecase>(
            (i) => FavoriteBookUseCaseImpl(bookRepository: i())),
        Bind.lazySingleton<IUnFavoriteBookUsecase>(
            (i) => UnFavoriteBookUseCaseImpl(bookRepository: i()))
      ];
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: ((context, args) => const HomePage())),
  ];
}
