import 'package:desafio_estante_de_livros/app/layers/presentation/widgets/app_subtitle_text.dart';
import 'package:flutter/material.dart';

import 'home_grid_view.dart';

class FavoritesTabView extends StatelessWidget {
  const FavoritesTabView(
      {super.key, required this.itemBuilder, required this.itemCount});
  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    if (itemCount == 0) {
      return const Center(
          child: AppSubTitleText(
              subTitle: "Você ainda não favoritou nenhum livro"));
    }
    return HomeGridView(
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
