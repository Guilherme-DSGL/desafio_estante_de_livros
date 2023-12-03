import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';

class AppImage extends StatelessWidget {
  const AppImage(
      {super.key,
      required this.imageUrl,
      this.height,
      this.width = AppSizes.size140});
  final String imageUrl;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) {
        return Image(
          height: height,
          width: width,
          image: imageProvider,
          fit: BoxFit.contain,
        );
      },
      errorWidget: (context, url, error) => Container(
        height: height,
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
    );
  }
}
