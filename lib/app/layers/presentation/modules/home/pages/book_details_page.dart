import 'package:desafio_estante_de_livros/app/layers/domain/entities/book_entity.dart';
import 'package:desafio_estante_de_livros/app/layers/presentation/widgets/app_title_text.dart';
import 'package:desafio_estante_de_livros/core/theme/app_sizes.dart';
import 'package:flutter/material.dart';

import '../../../widgets/app_image.dart';
import '../../../widgets/app_subtitle_text.dart';

class BookDetailsPage extends StatefulWidget {
  const BookDetailsPage({super.key, required this.bookEntity});
  final BookEntity bookEntity;
  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppTitleText(title: widget.bookEntity.title, softWrap: false),
      ),
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        padding:
            const EdgeInsets.only(left: AppSizes.size20, top: AppSizes.size20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: widget.bookEntity.id,
              child: AppImage(
                width: AppSizes.size250,
                imageUrl: widget.bookEntity.coverUrl,
              ),
            ),
            const SizedBox(height: AppSizes.size20),
            AppTitleText(
              title: widget.bookEntity.title,
              softWrap: true,
              maxLines: 2,
            ),
            AppSubTitleText(subTitle: widget.bookEntity.author),
            ElevatedButton(
              onPressed: () {},
              child: const AppSubTitleText(subTitle: "Ler Agora"),
            )
          ],
        ),
      ),
    );
  }
}
