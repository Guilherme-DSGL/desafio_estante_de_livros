import 'package:flutter/material.dart';

import '../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../core/theme/app_sizes.dart';
import '../../../../../domain/entities/book_entity.dart';
import '../../../../widgets/app_image.dart';
import '../../../../widgets/app_subtitle_text.dart';
import '../../../../widgets/app_title_text.dart';

class BookComponent extends StatelessWidget {
  const BookComponent(
      {super.key, required this.bookEntity, required this.favoriteBook});

  final BookEntity bookEntity;
  final VoidCallback? favoriteBook;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
      children: [
        _ImageBadge(
          onBadgePressed: favoriteBook,
          imageUrl: bookEntity.coverUrl,
          isSelected: bookEntity.isFavorite,
        ),
        Padding(
          padding: const EdgeInsets.all(AppSizes.size10),
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width - 230,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTitleText(
                  title: bookEntity.title,
                  textStyle: const TextStyle(fontSize: FontSize.fontSize24),
                ),
                AppSubTitleText(subTitle: bookEntity.author)
              ],
            ),
          ),
        ),
      ],
    ));
  }
}

class _ImageBadge extends StatelessWidget {
  const _ImageBadge({
    required this.imageUrl,
    required this.onBadgePressed,
    required this.isSelected,
  });

  final String imageUrl;
  final VoidCallback? onBadgePressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Badge(
      offset: const Offset(AppSizes.size20, -AppSizes.size20),
      largeSize: AppSizes.size70,
      backgroundColor: AppColors.transparent,
      label: IconButton(
          iconSize: AppSizes.size40,
          isSelected: isSelected,
          selectedIcon: const Icon(Icons.bookmark, color: AppColors.red),
          splashRadius: AppSizes.size40,
          onPressed: () {
            onBadgePressed?.call();
          },
          icon: const Icon(
            Icons.bookmark_border_outlined,
            color: AppColors.labelColor,
          )),
      child: AppImage(imageUrl: imageUrl),
    );
  }
}
