import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/book_entity.dart';
import '../../../../domain/use_cases/get_books/get_books_usecase_interface.dart';

part 'home_state.dart';

class HomeController extends Cubit<HomeState> {
  final IGetBooksUsecase _getBooksUsecase;

  HomeController({
    required IGetBooksUsecase getBooksUsecase,
  })  : _getBooksUsecase = getBooksUsecase,
        super(const HomeState.initial());

  List<BookEntity> get books => state.books;

  List<BookEntity> get favoritesBooks =>
      state.books.where((element) => element.isFavorite).toList();

  fetchAllBooks() async {
    emit(state.copyWith(status: HomeStatus.loading));
    final favorites = await _fetchFavoritesBooks();
    final booksApi = await _fecthBooksApi();
    final result = {...favorites, ...booksApi}.toList();
    emit(state.copyWith(books: result, status: HomeStatus.loaded));
  }

  Future<List<BookEntity>> _fecthBooksApi() async {
    try {
      return await _getBooksUsecase.call();
    } catch (e, s) {
      log('[CONTROLLER] GET BOOKS ITEMS', error: e, stackTrace: s);
      emit(state.copyWith(
          status: HomeStatus.failure,
          errorMessage: 'Não foi possível resgatar os livros'));
      return List.empty();
    }
  }

  Future<List<BookEntity>> _fetchFavoritesBooks() async {
    try {
      return await _getBooksUsecase.call();
    } catch (e, s) {
      log('[CONTROLLER] GET BOOKS ITEMS', error: e, stackTrace: s);
      emit(state.copyWith(
          status: HomeStatus.failure,
          errorMessage: 'Não foi possível resgatar os livros'));
      return List.empty();
    }
  }
}
