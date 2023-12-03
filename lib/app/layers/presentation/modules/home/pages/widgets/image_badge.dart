import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../core/theme/app_sizes.dart';
import '../../../../../domain/entities/book_entity.dart';
import '../../../../widgets/app_image.dart';
import '../../controllers/download_book_controller.dart';

class ImageBadge extends StatelessWidget {
  const ImageBadge({
    super.key,
    required this.onBadgePressed,
    required this.bookEntity,
  });

  final VoidCallback? onBadgePressed;
  final BookEntity bookEntity;

  @override
  Widget build(BuildContext context) {
    return Badge(
      offset: const Offset(AppSizes.size20, -AppSizes.size20),
      largeSize: AppSizes.size70,
      backgroundColor: AppColors.transparent,
      label: IconButton(
          iconSize: AppSizes.size40,
          isSelected: bookEntity.isFavorite,
          selectedIcon: const Icon(Icons.bookmark, color: AppColors.red),
          splashRadius: AppSizes.size40,
          onPressed: () {
            onBadgePressed?.call();
          },
          icon: const Icon(
            Icons.bookmark_border_outlined,
            color: AppColors.labelColor,
          )),
      child: InkWell(
          onTap: () {
            BlocProvider.of<DownloadBookController>(context)
                .openBook(bookEntity);
          },
          child: Hero(
              tag: bookEntity.id,
              child: AppImage(
                  height: AppSizes.size200, imageUrl: bookEntity.coverUrl))),
    );
  }
}
