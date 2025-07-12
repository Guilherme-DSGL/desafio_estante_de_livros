import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/app_title_text.dart';
import '../controllers/download_book_controller.dart';
import '../controllers/home_controller.dart';
import 'widgets/books_tab_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    required HomeController homeController,
    required DownloadBookController downloadBookController,
    super.key,
  })  : _homeController = homeController,
        _downloadBookController = downloadBookController;

  final HomeController _homeController;
  final DownloadBookController _downloadBookController;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    widget._homeController.fetchNextPage();
    super.initState();
  }

  void listenState(BuildContext context, HomeState state) {
    if (state.errorMessage != null) {
      AsukaSnackbar.warning(state.errorMessage ?? '').show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => widget._homeController),
        BlocProvider(create: (context) => widget._downloadBookController),
      ],
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const AppTitleText(title: 'Minha Estante '),
            bottom: TabBar(
              tabs: [
                const Tab(text: 'Livros'),
                BlocConsumer<HomeController, HomeState>(
                  listener: (context, state) {
                    print('Listener called with state: $state');
                  },
                  builder: (context, state) => Badge.count(
                    isLabelVisible: state.favoritesBooks.isNotEmpty,
                    largeSize: 15,
                    count: state.favoritesBooks.length,
                    child: const Tab(text: 'Favoritos'),
                  ),
                ),
              ],
            ),
          ),
          body: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: BlocConsumer<HomeController, HomeState>(
              listener: listenState,
              builder: (context, state) {
                if (state.status == HomeStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return BooksTabView(
                  books: state.books,
                  favoritesBooks: state.favoritesBooks,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
