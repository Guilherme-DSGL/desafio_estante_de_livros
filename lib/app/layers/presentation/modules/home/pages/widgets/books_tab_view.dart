import 'package:asuka/snackbars/asuka_snack_bar.dart';
import '../../../../../domain/entities/book_entity.dart';
import '../../controllers/home_controller.dart';
import '../../../../widgets/app_subtitle_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/download_book_controller.dart';
import 'book_component.dart';
import 'home_grid_view.dart';

class BooksTabView extends StatelessWidget {
  const BooksTabView(
      {super.key, required this.books, required this.favoritesBooks});
  final List<BookEntity> books;
  final List<BookEntity> favoritesBooks;

  void listenDownloadState(BuildContext context, DownloadBookState state) {
    if (state.errorMessage != null) {
      AsukaSnackbar.warning(state.errorMessage ?? "").show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DownloadBookController, DownloadBookState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: listenDownloadState,
        builder: (context, downloadState) {
          return TabBarView(children: [
            Builder(builder: (context) {
              if (books.isEmpty) {
                return const Center(
                    child: AppSubTitleText(
                        subTitle: "Não encontramos nenhum livro por aqui"));
              }
              return HomeGridView(
                onRefresh:
                    BlocProvider.of<HomeController>(context).fetchAllBooks,
                itemCount: books.length,
                itemBuilder: (context, index) => BookComponent(
                  isDownloading:
                      downloadState.booksInDownload.contains(books[index]),
                  favoriteBook: () {
                    BlocProvider.of<HomeController>(context)
                        .toggleFavoriteBook(bookEntity: books[index]);
                  },
                  bookEntity: books[index],
                ),
              );
            }),
            Builder(builder: (context) {
              if (favoritesBooks.isEmpty) {
                return const Center(
                    child: AppSubTitleText(
                        subTitle: "Não encontramos nenhum livro por aqui"));
              }
              return HomeGridView(
                onRefresh:
                    BlocProvider.of<HomeController>(context).fetchAllBooks,
                itemCount: favoritesBooks.length,
                itemBuilder: (context, index) => BookComponent(
                  isDownloading: downloadState.booksInDownload
                      .contains(favoritesBooks[index]),
                  favoriteBook: () {
                    BlocProvider.of<HomeController>(context)
                        .toggleFavoriteBook(bookEntity: favoritesBooks[index]);
                  },
                  bookEntity: favoritesBooks[index],
                ),
              );
            }),
          ]);
        });
  }
}
