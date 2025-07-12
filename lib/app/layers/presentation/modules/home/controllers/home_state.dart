part of 'home_controller.dart';

enum HomeStatus { initial, loading, loadingMore, loaded, failure }

class HomeState extends Equatable {
  const HomeState._({
    required this.status,
    required this.books,
    required this.page,
    required this.hasMore,
    this.errorMessage,
  });

  const HomeState.initial()
      : this._(
          books: const [],
          status: HomeStatus.initial,
          page: 0,
          hasMore: true,
        );

  final HomeStatus status;
  final List<BookEntity> books;
  final String? errorMessage;
  final int page;
  final bool hasMore;

  List<BookEntity> get favoritesBooks =>
      books.where((element) => element.isFavorite).toList();

  bool get isLoadingMore => status == HomeStatus.loadingMore;

  @override
  List<Object?> get props => [status, books, errorMessage, page, hasMore];

  HomeState copyWith({
    HomeStatus? status,
    List<BookEntity>? books,
    String? errorMessage,
    int? page,
    bool? hasMore,
  }) =>
      HomeState._(
        books: books ?? this.books,
        status: status ?? this.status,
        errorMessage: errorMessage,
        page: page ?? this.page,
        hasMore: hasMore ?? this.hasMore,
      );
}
