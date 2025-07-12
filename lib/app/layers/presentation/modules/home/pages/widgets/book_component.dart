import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../core/routes/routes.dart';
import '../../../../../../../core/theme/app_sizes.dart';
import '../../../../../domain/entities/book_entity.dart';
import '../../../../widgets/app_subtitle_text.dart';
import '../../../../widgets/app_title_text.dart';
import 'image_badge.dart';

class BookComponent extends StatelessWidget {
  const BookComponent({
    required this.bookEntity,
    required this.favoriteBook,
    required this.isDownloading,
    super.key,
  });

  final BookEntity bookEntity;
  final VoidCallback? favoriteBook;
  final bool isDownloading;

  @override
  Widget build(BuildContext context) {
    final List<Widget> listWidgets = [
      Stack(
        children: [
          ImageBadge(
            onBadgePressed: favoriteBook,
            bookEntity: bookEntity,
          ),
          SizedBox(
            width: AppSizes.size140,
            child: Align(
              child: Visibility(
                visible: isDownloading,
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(width: AppSizes.size10),
      InkWell(
        onTap: () {
          Modular.to.pushNamed(Routes.bookDeatils, arguments: bookEntity);
        },
        child: SizedBox(
          width: MediaQuery.orientationOf(context) == Orientation.landscape
              ? AppSizes.size140
              : MediaQuery.sizeOf(context).width - AppSizes.size230,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTitleText(
                title: bookEntity.title,
                maxLines: 2,
                textStyle: const TextStyle(fontSize: FontSize.fontSize16),
              ),
              AppSubTitleText(
                subTitle: bookEntity.author,
                textStyle: const TextStyle(fontSize: FontSize.fontSize12),
              ),
            ],
          ),
        ),
      ),
    ];
    return Card(
      child: LayoutBuilder(
        builder: (context, constrains) {
          if (MediaQuery.orientationOf(context) == Orientation.portrait) {
            return Row(
              children: listWidgets,
            );
          } else {
            return Column(
              children: listWidgets,
            );
          }
        },
      ),
    );
  }
}
