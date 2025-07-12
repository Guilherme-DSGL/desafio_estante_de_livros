import 'package:flutter_modular/flutter_modular.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../../core/infrastructure/local_db/local_db_impl.dart';
import '../../../../../core/infrastructure/local_db/local_db_interface.dart';
import '../../../../../core/infrastructure/network/http_client/http_client_adapter_impl.dart';
import '../../../../../core/infrastructure/network/http_client/http_client_adapter_interface.dart';
import '../../../data/datasources/local/local_book_datasource_impl.dart';
import '../../../data/datasources/remote/remote_book_datasource_impl.dart';
import '../../../data/datasources/remote_book_datasource_interfaces.dart';
import '../../../data/repositories/book_repository_impl.dart';
import '../../../domain/repositories/book_repository_interface.dart';
import '../../../domain/use_cases/download_book/download_book_usecase_impl.dart';
import '../../../domain/use_cases/download_book/download_book_usecase_interface.dart';
import '../../../domain/use_cases/favorite_book/favorite_book_usecase_impl.dart';
import '../../../domain/use_cases/favorite_book/favorite_book_usecase_interface.dart';
import '../../../domain/use_cases/get_books/get_books_usecase_impl.dart';
import '../../../domain/use_cases/get_books/get_books_usecase_interface.dart';
import '../../../domain/use_cases/get_favorites_books/get_favorites_books_usecase_impl.dart';
import '../../../domain/use_cases/get_favorites_books/get_favorites_books_usecase_interface.dart';
import '../../../domain/use_cases/un_favorite_book/un_favorite_book_usecase_impl.dart';
import '../../../domain/use_cases/un_favorite_book/un_favorite_book_usecase_interface.dart';
import 'controllers/download_book_controller.dart';
import 'controllers/home_controller.dart';
import 'pages/book_details_page.dart';
import 'pages/home_page.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        ..._getInfraBinds(),
        ..._getDataSourcesBinds(),
        ..._getRepositoriesBinds(),
        ..._getUseCasesBinds(),
        ..._getControllersBinds(),
      ];
  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => HomePage(
        homeController: Modular.get<HomeController>(),
        downloadBookController: Modular.get<DownloadBookController>(),
      ),
    ),
    ChildRoute(
      '/book-details',
      child: (context, args) => BookDetailsPage(bookEntity: args.data),
    ),
  ];

  static List<Bind> _getInfraBinds() => [
        Bind.singleton<ILocalDBProvider<Database>>(
          (i) => LocalDBProviderImpl.instance,
        ),
        Bind.lazySingleton<IHttpClientAdapter>((i) => HttpClientAdapterImpl()),
      ];

  static List<Bind> _getDataSourcesBinds() => [
        Bind.lazySingleton<ILocalBookDataSource>(
          (i) => LocalBookDataSource(localDBProvider: i()),
        ),
        Bind.lazySingleton<IRemoteBookDataSource>(
          (i) => RemoteBookDataSourceImpl(httpClientAdapter: i()),
        ),
      ];

  static List<Bind> _getRepositoriesBinds() => [
        Bind.lazySingleton<IBookRepository>(
          (i) => BookRepositoryImpl(
            localBookDataSource: i(),
            remoteBookRepository: i(),
          ),
        ),
      ];

  static List<Bind> _getUseCasesBinds() => [
        Bind.lazySingleton<IGetBooksUsecase>(
          (i) => GetBooksUseCaseImpl(bookRepository: i()),
        ),
        Bind.lazySingleton<IGetFavoritesBooksUsecase>(
          (i) => GetFavoritesBooksUseCaseImpl(bookRepository: i()),
        ),
        Bind.lazySingleton<IFavoriteBookUsecase>(
          (i) => FavoriteBookUseCaseImpl(bookRepository: i()),
        ),
        Bind.lazySingleton<IUnFavoriteBookUsecase>(
          (i) => UnFavoriteBookUseCaseImpl(bookRepository: i()),
        ),
        Bind.lazySingleton<IDownloadBookUsecase>(
          (i) => DownloadBookUsecaseImpl(bookrepository: i()),
        ),
      ];

  static List<Bind> _getControllersBinds() => [
        Bind.lazySingleton<HomeController>(
          (i) => HomeController(
            getBooksUsecase: i(),
            favoriteBookUsecase: i(),
            unFavoriteBookUsecase: i(),
            getFavoritesBooksUsecase: i(),
          ),
        ),
        Bind.lazySingleton<DownloadBookController>(
          (i) => DownloadBookController(downloadBookUsecase: i()),
        ),
      ];
}
