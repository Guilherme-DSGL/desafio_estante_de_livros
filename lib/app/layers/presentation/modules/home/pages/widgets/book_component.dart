import 'package:flutter/material.dart';

import '../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../core/theme/app_sizes.dart';
import '../../../../../domain/entities/book_entity.dart';
import '../../../../widgets/app_image.dart';
import '../../../../widgets/app_subtitle_text.dart';
import '../../../../widgets/app_title_text.dart';

class BookComponent extends StatefulWidget {
  const BookComponent({super.key, required this.bookEntity});

  final BookEntity bookEntity;

  @override
  State<BookComponent> createState() => _BookComponentState();
}

class _BookComponentState extends State<BookComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Card(
          child: Row(
        children: [
          _ImageBadge(
            onBadgePressed: null,
            imageUrl: widget.bookEntity.coverUrl,
            isSelected: widget.bookEntity.isFavorite,
          ),
          Padding(
            padding: const EdgeInsets.all(AppSizes.size10),
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width - 230,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTitleText(
                    title: widget.bookEntity.title,
                    textStyle: const TextStyle(fontSize: FontSize.fontSize24),
                  ),
                  AppSubTitleText(subTitle: widget.bookEntity.author)
                ],
              ),
            ),
          ),
        ],
      )),
    );
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
