import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../core/theme/app_sizes.dart';
import '../../../../domain/entities/book_entity.dart';
import '../../../widgets/app_image.dart';
import '../../../widgets/app_subtitle_text.dart';
import '../../../widgets/app_title_text.dart';
import '../controllers/download_book_controller.dart';

class BookDetailsPage extends StatefulWidget {
  const BookDetailsPage({required this.bookEntity, super.key});
  final BookEntity bookEntity;
  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  final DownloadBookController downloadController =
      Modular.get<DownloadBookController>();
  var existBook = false;

  @override
  void initState() {
    exixtsBook();
    super.initState();
  }

  Future<void> exixtsBook() async {
    existBook = await downloadController.existFile(widget.bookEntity);
  }

  void onPressed() {
    if (existBook) {
      downloadController.openBook(widget.bookEntity);
    } else {}
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: AppTitleText(title: widget.bookEntity.title, softWrap: false),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            padding: const EdgeInsets.only(
              left: AppSizes.size20,
              top: AppSizes.size20,
            ),
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
                  maxLines: 2,
                ),
                AppSubTitleText(subTitle: widget.bookEntity.author),
                BlocBuilder<DownloadBookController, DownloadBookState>(
                  bloc: Modular.get<DownloadBookController>(),
                  builder: (context, state) => SizedBox(
                    width: AppSizes.size150,
                    child: ElevatedButton(
                      onPressed: !(state.status == DownloadBookStatus.loading)
                          ? () async {
                              await downloadController
                                  .openBook(widget.bookEntity);
                              unawaited(exixtsBook());
                            }
                          : null,
                      child: Visibility(
                        visible: state.status != DownloadBookStatus.loading,
                        replacement: const CircularProgressIndicator(),
                        child: AppSubTitleText(
                          subTitle: existBook ? 'Ler Agora' : 'Downaload',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.size50),
              ],
            ),
          ),
        ),
      );
}
