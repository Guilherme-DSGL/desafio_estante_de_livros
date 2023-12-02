import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';

class AppImage extends StatelessWidget {
  const AppImage({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSizes.size140,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) {
          return Image(
            image: imageProvider,
          );
        },
        errorWidget: (context, url, error) => Container(
          height: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(
            color: AppColors.borderColor,
          )),
          child: const Icon(
            Icons.broken_image_outlined,
            size: 45,
            color: AppColors.dangerColor,
          ),
        ),
      ),
    );
  }
}
