import 'package:asuka/snackbars/asuka_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/entities/book_entity.dart';
import '../../../../widgets/app_subtitle_text.dart';
import '../../controllers/download_book_controller.dart';
import '../../controllers/home_controller.dart';
import 'book_component.dart';
import 'home_grid_view.dart';

class BooksTabView extends StatefulWidget {
  const BooksTabView({
    required this.books,
    required this.favoritesBooks,
    super.key,
  });
  final List<BookEntity> books;
  final List<BookEntity> favoritesBooks;

  @override
  State<BooksTabView> createState() => _BooksTabViewState();
}

class _BooksTabViewState extends State<BooksTabView> {
  final _scrollController = ScrollController();

  void listenDownloadState(BuildContext context, DownloadBookState state) {
    if (state.errorMessage != null) {
      AsukaSnackbar.warning(state.errorMessage ?? '').show();
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final HomeController controller = context.read<HomeController>();
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 900) {
      controller.fetchNextPage();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<DownloadBookController, DownloadBookState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: listenDownloadState,
        builder: (context, downloadState) => TabBarView(
          children: [
            Builder(
              builder: (context) {
                if (widget.books.isEmpty) {
                  return const Center(
                    child: AppSubTitleText(
                      subTitle: 'Não encontramos nenhum livro por aqui',
                    ),
                  );
                }
                return HomeGridView(
                  scrollController: _scrollController,
                  onRefresh: BlocProvider.of<HomeController>(context).refresh,
                  itemCount: widget.books.length,
                  itemBuilder: (context, index) => BookComponent(
                    isDownloading: downloadState.booksInDownload.contains(
                      widget.books[index],
                    ),
                    favoriteBook: () {
                      BlocProvider.of<HomeController>(context)
                          .toggleFavoriteBook(
                        bookEntity: widget.books[index],
                      );
                    },
                    bookEntity: widget.books[index],
                  ),
                );
              },
            ),
            Builder(
              builder: (context) {
                if (widget.favoritesBooks.isEmpty) {
                  return const Center(
                    child: AppSubTitleText(
                      subTitle: 'Não encontramos nenhum livro por aqui',
                    ),
                  );
                }
                return HomeGridView(
                  onRefresh: BlocProvider.of<HomeController>(context).refresh,
                  itemCount: widget.favoritesBooks.length,
                  itemBuilder: (context, index) => BookComponent(
                    isDownloading: downloadState.booksInDownload
                        .contains(widget.favoritesBooks[index]),
                    favoriteBook: () {
                      BlocProvider.of<HomeController>(context)
                          .toggleFavoriteBook(
                        bookEntity: widget.favoritesBooks[index],
                      );
                    },
                    bookEntity: widget.favoritesBooks[index],
                  ),
                );
              },
            ),
          ],
        ),
      );
}
