import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import '../../../../data/dtos/book_dto.dart';
import '../../../../domain/use_cases/favorite_book/favorite_book_usecase_interface.dart';
import '../../../../domain/use_cases/get_favorites_books/get_favorites_books_usecase_interface.dart';
import '../../../../domain/use_cases/un_favorite_book/un_favorite_book_usecase_interface.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/book_entity.dart';
import '../../../../domain/use_cases/get_books/get_books_usecase_interface.dart';

part 'home_state.dart';

class HomeController extends Cubit<HomeState> {
  final IGetBooksUsecase _getBooksUsecase;
  final IFavoriteBookUsecase _favoriteBookUsecase;
  final IUnFavoriteBookUsecase _unFavoriteBookUsecase;
  final IGetFavoritesBooksUsecase _getFavoritesBooksUsecase;

  HomeController({
    required IGetBooksUsecase getBooksUsecase,
    required IFavoriteBookUsecase favoriteBookUsecase,
    required IUnFavoriteBookUsecase unFavoriteBookUsecase,
    required IGetFavoritesBooksUsecase getFavoritesBooksUsecase,
  })  : _getBooksUsecase = getBooksUsecase,
        _favoriteBookUsecase = favoriteBookUsecase,
        _unFavoriteBookUsecase = unFavoriteBookUsecase,
        _getFavoritesBooksUsecase = getFavoritesBooksUsecase,
        super(const HomeState.initial());

  fetchAllBooks() async {
    emit(state.copyWith(status: HomeStatus.loading));
    final favorites = await _fetchFavoritesBooks();
    final booksApi = await _fecthBooksApi();
    final result = booksApi.map((e) {
      if (favorites.contains(e)) {
        return BookDTO.fromEntity(e).copyWith(isFavorite: true);
      }
      return e;
    }).toList();
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
      return await _getFavoritesBooksUsecase.call();
    } catch (e, s) {
      log('[CONTROLLER] GET BOOKS ITEMS', error: e, stackTrace: s);
      emit(state.copyWith(
          status: HomeStatus.failure,
          errorMessage: 'Não foi possível resgatar os livros'));
      return List.empty();
    }
  }

  Future<void> toggleFavoriteBook({required BookEntity bookEntity}) async {
    if (bookEntity.isFavorite) {
      await _unFavoriteBook(bookEntity: bookEntity);
    } else {
      await favoriteBook(bookEntity: bookEntity);
    }
  }

  Future<void> favoriteBook({required BookEntity bookEntity}) async {
    try {
      final book = await _favoriteBookUsecase.call(bookEntity: bookEntity);
      final result = state.books
          .map((e) => e == book
              ? BookDTO.fromEntity(e).copyWith(isFavorite: book.isFavorite)
              : e)
          .toList();
      emit(state.copyWith(books: result));
    } catch (e, s) {
      log('[CONTROLLER] Favorite BOOK', error: e, stackTrace: s);
      emit(state.copyWith(
          status: HomeStatus.failure,
          errorMessage: 'Não foi possível favoritar o livro'));
    }
  }

  Future<void> _unFavoriteBook({required BookEntity bookEntity}) async {
    try {
      final book = await _unFavoriteBookUsecase.call(bookEntity: bookEntity);
      final result = state.books
          .map((e) => e == book
              ? BookDTO.fromEntity(e).copyWith(isFavorite: book.isFavorite)
              : e)
          .toList();
      emit(state.copyWith(books: result));
    } catch (e, s) {
      log('[CONTROLLER] unfavorite BOOKS ', error: e, stackTrace: s);
      emit(state.copyWith(
          status: HomeStatus.failure,
          errorMessage: 'Não foi possível desfavoritar o livro'));
    }
  }
}
