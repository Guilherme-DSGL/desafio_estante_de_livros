import 'package:desafio_estante_de_livros/app/layers/presentation/widgets/app_subtitle_text.dart';
import 'package:flutter/material.dart';

import 'home_grid_view.dart';

class BooksTabView extends StatelessWidget {
  const BooksTabView(
      {super.key, required this.itemBuilder, required this.itemCount});
  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (itemCount == 0) {
        return const Center(
            child: AppSubTitleText(subTitle: "Não há nenhum livro por aqui"));
      }
      return HomeGridView(
        itemCount: itemCount,
        itemBuilder: itemBuilder,
      );
    });
  }
}
