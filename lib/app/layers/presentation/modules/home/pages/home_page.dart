import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/app_title_text.dart';
import '../controllers/home_controller.dart';
import 'widgets/book_component.dart';
import 'widgets/books_tab_view.dart';
import 'widgets/favorites_tab_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required HomeController homeController})
      : _homeController = homeController;
  final HomeController _homeController;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    widget._homeController.fetchAllBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const tabsList = [Tab(text: "Livros"), Tab(text: "Favoritos")];
    return BlocProvider(
      create: (context) => widget._homeController,
      child: DefaultTabController(
        length: tabsList.length,
        child: Scaffold(
            appBar: AppBar(
              title: const AppTitleText(
                title: "Minha Estante ",
              ),
              bottom: const TabBar(tabs: tabsList),
            ),
            body: SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: BlocConsumer<HomeController, HomeState>(
                listener: (context, state) {
                  if (state.status == HomeStatus.failure) {
                    AsukaMaterialBanner.alert(state.errorMessage ?? "");
                  }
                },
                builder: (context, state) {
                  if (state.status == HomeStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return TabBarView(children: [
                    BooksTabView(
                      itemCount: state.books.length,
                      itemBuilder: (context, index) => BookComponent(
                        favoriteBook: () {
                          widget._homeController.toggleFavoriteBook(
                              bookEntity: state.books[index]);
                        },
                        bookEntity: state.books[index],
                      ),
                    ),
                    FavoritesTabView(
                      itemCount: state.favoritesBooks.length,
                      itemBuilder: (context, index) => BookComponent(
                        favoriteBook: () {
                          widget._homeController.toggleFavoriteBook(
                              bookEntity: state.favoritesBooks[index]);
                        },
                        bookEntity: state.favoritesBooks[index],
                      ),
                    ),
                  ]);
                },
              ),
            )),
      ),
    );
  }
}
