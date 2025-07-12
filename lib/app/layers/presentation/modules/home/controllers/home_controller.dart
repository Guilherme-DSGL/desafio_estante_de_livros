import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/errors/messages.dart';
import '../../../../data/dtos/book_dto.dart';
import '../../../../domain/entities/book_entity.dart';
import '../../../../domain/use_cases/favorite_book/favorite_book_usecase_interface.dart';
import '../../../../domain/use_cases/get_books/get_books_usecase_interface.dart';
import '../../../../domain/use_cases/get_favorites_books/get_favorites_books_usecase_interface.dart';
import '../../../../domain/use_cases/un_favorite_book/un_favorite_book_usecase_interface.dart';

part 'home_state.dart';

class HomeController extends Cubit<HomeState> {
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

  final IGetBooksUsecase _getBooksUsecase;
  final IFavoriteBookUsecase _favoriteBookUsecase;
  final IUnFavoriteBookUsecase _unFavoriteBookUsecase;
  final IGetFavoritesBooksUsecase _getFavoritesBooksUsecase;

  Future<List<BookEntity>> _fecthBooksApi({int page = 1}) async {
    try {
      return await _getBooksUsecase.call(page: page);
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          errorMessage: ErrorMessages.getBooksError,
        ),
      );
      return List.empty();
    }
  }

  Future<void> fetchNextPage({bool reset = false}) async {
    if (state.isLoadingMore || !state.hasMore) return;

    emit(state.copyWith(status: HomeStatus.loadingMore));

    final int nextPage = state.page + 1;
    final List<BookEntity> favorites = await _fetchFavoritesBooks();
    final List<BookEntity> newBooks = await _fecthBooksApi(page: nextPage);

    if (newBooks.isEmpty) {
      emit(state.copyWith(status: HomeStatus.loaded, hasMore: false));
      return;
    }

    final List<BookEntity> mergedBooks = reset ? [] : [...state.books];
    for (final book in newBooks) {
      final bool isFav = favorites.any((fav) => fav.id == book.id);
      final BookEntity bookWithFav =
          isFav ? BookDTO.fromEntity(book).copyWith(isFavorite: true) : book;
      mergedBooks.add(bookWithFav);
    }

    emit(
      state.copyWith(
        books: mergedBooks.toSet().toList(),
        status: HomeStatus.loaded,
        page: nextPage,
      ),
    );
  }

  Future<List<BookEntity>> _fetchFavoritesBooks() async {
    try {
      return await _getFavoritesBooksUsecase.call();
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          errorMessage: ErrorMessages.getFavoritesBooksError,
        ),
      );
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
      final BookEntity book =
          await _favoriteBookUsecase.call(bookEntity: bookEntity);
      final List<BookEntity> result = state.books
          .map(
            (e) => e.id == book.id
                ? BookDTO.fromEntity(e).copyWith(isFavorite: book.isFavorite)
                : e,
          )
          .toList();
      emit(state.copyWith(books: result, status: HomeStatus.loaded));
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          errorMessage: ErrorMessages.favoriteBookError,
        ),
      );
    }
  }

  Future<void> _unFavoriteBook({required BookEntity bookEntity}) async {
    try {
      final BookEntity book =
          await _unFavoriteBookUsecase.call(bookEntity: bookEntity);
      final List<BookEntity> result = state.books
          .map(
            (e) => e.id == book.id
                ? BookDTO.fromEntity(e).copyWith(isFavorite: book.isFavorite)
                : e,
          )
          .toList();
      emit(state.copyWith(books: result, status: HomeStatus.loaded));
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          errorMessage: ErrorMessages.unfavoreteBookError,
        ),
      );
    }
  }

  Future<void> reset() async {
    emit(
      state.copyWith(
        status: HomeStatus.initial,
        page: 0,
        hasMore: true,
      ),
    );
  }

  Future<void> refresh() async {
    await reset();
    await fetchNextPage(reset: true);
  }
}
