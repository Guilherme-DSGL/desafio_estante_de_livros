part of 'home_controller.dart';

enum HomeStatus { initial, loading, loaded, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<BookEntity> books;
  final String? errorMessage;

  List<BookEntity> get favoritesBooks =>
      books.where((element) => element.isFavorite).toList();

  const HomeState._({
    required this.status,
    required this.books,
    this.errorMessage,
  });

  const HomeState.initial()
      : this._(
          books: const [],
          status: HomeStatus.initial,
        );

  @override
  List<Object?> get props => [status, errorMessage, books, favoritesBooks];

  HomeState copyWith({
    HomeStatus? status,
    List<BookEntity>? books,
    String? errorMessage,
  }) {
    return HomeState._(
      status: status ?? this.status,
      books: books ?? this.books,
      errorMessage: errorMessage,
    );
  }
}
